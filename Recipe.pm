package Recipe;

use strict;
use warnings;

use Carp;
use Cwd;
use LWP::Simple;
use File::Basename;
use File::Path;
use Archive::Extract;
use Digest::MD5;

our $AUTOLOAD;

###############################################################################
## class variables

    my $debugging_ = 0;

###############################################################################
## member fields

    my %fields =
		(
        name         => undef,
        url          => undef,
        version      => undef,
        package_name => undef,
        sandbox      => undef,
        prefix       => undef,
				verbose      => 0,
				debug        => 0,
    );

###############################################################################
## constructors and destructors

    sub new {
        my $proto = shift;
        my $class = ref($proto) || $proto;
        my $self  = {
            _permitted => \%fields,
            %fields,
        };
        bless $self, $class;
        return $self;
    }

    # proxy method
    sub AUTOLOAD {
        my $self = shift;
        my $type = ref($self) or croak "$self is not an object";
        my $name = $AUTOLOAD;
        $name =~ s/.*://;   # strip fully-qualified portion
        unless (exists $self->{_permitted}->{$name} ) {
            croak "Can't access `$name' field in class $type";
        }
        if (@_) {
            return $self->{$name} = shift; # works as mutator
        } else {
            return $self->{$name};         # works as accessor
        }
    }

    # destructor
    sub DESTROY {
        my $self = shift;
        if ($debugging_) { carp "destroying $self " . $self->name }
    }

		# debugging support
    sub debug {
        my $self = shift;
        if (@_) {
        	my $level = shift;
        	if (ref($self))  {
            $self->{debug} = $level;
        	} else {
            $debugging_ = $level;            # whole class
        	}
				}
				else { return ( $self->{debug} || $debugging_ ) };
    }

###############################################################################
## public methods

		sub chdir_to {
			my $self = shift;
			my $dir  = shift;
			chdir($dir) or die "cannot chdir to '$dir' ($!)";
		}

		# executes the command or dies trying
		sub execute_command {
			my $self = shift;
			my $command = shift;
			my $dir = cwd();
			if($self->debug) { print "> executing [$command] in [$dir]\n" };
			my $result = `$command 2>&1`;
			if( $? == -1 ) { die "command [$command] failed: $!\n"; }
			return $result;
		}

		# returns the package name or $name-$version is undef
    sub package_name {
        my $self = shift;
        if (@_) { return $self->{package_name} = shift }
				else {
					if($self->{package_name})
					{ return $self->{package_name}; }
					else
					{ return sprintf "%s-%s", $self->name, $self->version; }
				}
    }

		# by default package_dir is same as $package_name
    sub package_dir {
        my $self = shift;
        if (@_) { return $self->{package_dir} = shift }
				else {
					if($self->{package_dir})
					{ return $self->{package_dir}; }
					else
					{ return $self->package_name; }
				}
    }

		# returns sandbox dir and ensures it exists
    sub sandbox_dir {
        my $self = shift;
				my $sandbox = $self->sandbox;
				if($sandbox) {
					mkpath $sandbox unless( -e $sandbox );
				} else { die "no sandbox defined for " . $self->package_name; }
				return $sandbox;
    }

		# gets the path to the build dir
    sub build_dir {
        my $self = shift;
				my $pname = $self->package_name;
				return sprintf return sprintf "%s/%s", $self->sandbox_dir, $self->package_dir;
    }

		# get the source file name from the url
		sub src_file {
        my $self = shift;
				return  sprintf "%s/%s", $self->sandbox_dir, basename($self->url);
		}

		# downloads the source package
    sub download_src {
        my $self = shift;
				if($self->verbose) { print "> downloading source for " . $self->name ."\n" };
        my $url = $self->url;
        my $file = $self->src_file;
				if( -e $file ) {
					if($self->debug) { print "> $file exists, not downloading\n" };
				}
				else {
					if($self->debug) { print "> downloading $url into $file\n" };
					my $rs = getstore( $url, $file ) or die "cannot download to $file ($!)";
                    if(!is_success($rs)) { die "unsuccessful download of $url ($!)"; }
				}
    }

		# check md5sum on the package file
		sub check_md5 {
			my $self = shift;
			if($self->verbose) { print "> md5 check for " . $self->name ."\n" };
			if($self->md5)
			{
       	my $file = $self->src_file;
				my $md5 = $self->md5;
				open(FILE, $file) or die "Can't open '$file': $!";
   			binmode(FILE);
   			my $computed_md5 = Digest::MD5->new->addfile(*FILE)->hexdigest;
				if ( $md5 eq $computed_md5 )
				{
				  if($self->debug) { print "> $file has correct md5 sum check [$md5]\n" };
				}
				else { die "file '$file' has md5sum unexpected md5 sum check [$computed_md5]"}
			}
		}

		# unpack the source
		sub unpack_src {
        my $self = shift;
				$self->cleanup(); # ensure nothing is on the way
				my $sandbox = $self->sandbox_dir;
				print "> unpacking source for " . $self->name ." to $sandbox\n" unless (!$self->verbose);
				$self->chdir_to($sandbox);
				my $pname = $self->package_name;
    		my $archive = Archive::Extract->new( archive => $self->src_file );
    		return
					$archive->extract( to => $sandbox ) or die $archive->error;
		}

		# configure the package for building
		sub configure {
			my $self = shift;
			print "> configure build of " . $self->name ."\n" if ($self->verbose);
			$self->chdir_to($self->build_dir);
			die "no install dir prefix defined for ". $self->package_name unless($self->prefix);
			my $output = $self->execute_command( $self->configure_command() );
			if($self->debug) { print "$output\n" };
		}

		# string for the configure command
		sub configure_command {
			my $self = shift;
			return "./configure --prefix=" . $self->prefix;
		}

		# builds the package
		sub build {
			my $self = shift;
			print "> building " . $self->name ."\n" if($self->verbose);
			$self->chdir_to($self->build_dir);
			my $output = $self->execute_command( $self->build_command() );
			if($self->debug) { print "$output\n" };
		}

		# string for the build command
		sub build_command {
			my $self = shift;
			return "make";
		}

		# installs the package
		sub install {
			my $self = shift;
			print "> installing " . $self->name ."\n" if($self->verbose);
			$self->chdir_to($self->build_dir);
			my $output = $self->execute_command(  $self->install_command() );
			if($self->debug) { print "$output\n" };
		}

		# string for the build command
		sub install_command {
			my $self = shift;
			return "make install";
		}

		# cleans up the build directory
		sub cleanup {
			my $self = shift;
			print "> cleaning up sanbox " . $self->build_dir ."\n" if($self->verbose);
			$self->chdir_to($self->sandbox_dir);
			rmtree( $self->build_dir );
		}

		# installs the package
		sub cook
		{
        my $self = shift;

				$self->download_src();

				$self->check_md5();

				$self->unpack_src();

				$self->configure();

				$self->build();

				$self->install();

				$self->cleanup();
		}

1;  # close package Recipe
