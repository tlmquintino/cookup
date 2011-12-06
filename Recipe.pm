package Recipe;

use strict;
use warnings;

use Carp;
use Cwd;
use LWP::Simple; 
use File::Basename; 
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
        build_dir    => undef,
        install_dir  => undef,
				verbose      => 0,
				debug_       => 0,
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
            $self->{debug_} = $level;
        	} else {
            $debugging_ = $level;            # whole class
        	}
				}
				else { return ( $self->{debug_} || $debugging_ ) };
    }

###############################################################################
## public methods

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

		# returns the build_dir or $package_name is undef
    sub build_dir {
        my $self = shift;
        if (@_) { return $self->{build_dir} = shift }
				else {
					if($self->{build_dir}) 
					{ return $self->{build_dir}; }
					else
					{ return $self->package_name; }
				}
    }

		# get the source file name from the url
		sub src_file { 
        my $self = shift;
				return basename($self->url);
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
					getstore( $url, $file ) or die "cannot download to $file ($!)";
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

		# uncompresses the source
		sub uncompress_src {
        my $self = shift;
				if($self->verbose) { print "> uncompressing source for " . $self->name ."\n" };
    		my $archive = Archive::Extract->new( archive => $self->src_file );
    		return 
					$archive->extract( to => cwd() ) or die $archive->error;
		}

		# cd into the build directory
		sub cd_to_src {
			my $self = shift;
			if($self->verbose) { print "> cd into build tree of " . $self->name ."\n" };
			my $dir = $self->build_dir;
			chdir($dir) or die "cannot chdir to $dir ($!)";
		}

		# configure the package for building
		sub configure {
			my $self = shift;
			if($self->verbose) { print "> configure build of " . $self->name ."\n" };
			my $prefix = $self->install_dir();
			my $output = $self->execute_command( "./configure --prefix=$prefix" );
			if($self->debug) { print "$output\n" };
		}

		# builds the package
		sub build {
			my $self = shift;
			if($self->verbose) { print "> building " . $self->name ."\n" };
			my $output = $self->execute_command( "make" );
			if($self->debug) { print "$output\n" };
		}

		# installs the package in the install_dir
		sub install {
			my $self = shift;
			if($self->verbose) { print "> installing " . $self->name ."\n" };
			my $output = $self->execute_command( "make install" );
			if($self->debug) { print "$output\n" };
		}

		# cleans up the build directory
		sub cleanup {		
			my $self = shift;
			if($self->verbose) { print "> cleaning up build of " . $self->name ."\n" };
			# do nothing by default
		}

		# installs the package
		sub cook
		{
        my $self = shift;
			
				$self->download_src();
				
				$self->check_md5();
				
				$self->uncompress_src();

				$self->cd_to_src();
				
				$self->configure();				
				
				$self->build();
			
				$self->install();			

				$self->cleanup();
		}

1;  # close package Recipe
