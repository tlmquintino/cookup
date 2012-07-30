package Recipe;

use strict;
use warnings;

use Carp;
use Cwd;
use File::Basename;
use File::Path;
use Digest::MD5;
use Digest::SHA1  qw(sha1);

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
## helper methods - maybe should be mode to a helper module

      sub which {
            my $self = shift;
            my $program = shift;
            return if (not defined($program)); # return if nothing is provided
            my $path = $ENV{PATH}; # get the PATH
            $path =~ s/\/:/:/g; # substitute all /: by :
            my @path = split(/:/,$path); # make an array

            foreach (@path) { # find if the file is in one of the paths
              my $file = $_ . '/' . $program; # concatenate the file
              return $file if ((-e $file) && (-f $file)); # return if found
            }
        }

		sub chdir_to {
			my $self = shift;
			my $dir  = shift;
			if($self->debug) { print "[change dir] $dir\n" };
			chdir($dir) or die "cannot chdir to '$dir' ($!)";
		}

		# executes the command or dies trying
		# TODO: change this to return the value from the command and put the output on a variable
		sub execute_command {
			my $self = shift;
			my $command = shift;
			my $dir = cwd();
			print "> executing [$command] in [$dir]\n" if($self->debug);
			my $result = `$command 2>&1`;
			if( $? == -1 ) { die "command [$command] failed: $!\n"; }
			return $result;
		}

    sub check_command() {
      my $self = shift;
      my $comm = shift;
      my $status = $self->execute_command("which $comm");
      return 0 if ($status eq "");
      return 1;
    }

###############################################################################
## public methods


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
				return $self->package_name;
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

		# gets the path to the build dir - usually the same as source dir
    sub build_dir {
        my $self = shift;
        return $self->source_dir;
    }
    
		# gets the path to the source dir
    sub source_dir {
        my $self = shift;
				my $pname = $self->package_name;
				return sprintf "%s/%s", $self->sandbox_dir, $self->package_dir;
    }

		# get the source file name from the url
		sub src_file {
        my $self = shift;
				return  sprintf "%s/%s", $self->sandbox_dir, basename($self->url);
		}

    sub download_with_lwp() {
      my $self = shift;
      my $url = shift;
      my $file = shift;
      print "> downloading $url with perl::LWP\n" if($self->verbose);
      my $browser = LWP::UserAgent->new;
      $browser->env_proxy;
      my $response = $browser->get( $url );
      die "unsuccessful download of $url -- ", $response->status_line unless $response->is_success;
      open(FH, ">$file");
      binmode(FH);
      print FH $response->content;
      close (FH);
      # used with LWP::Simple
      #					my $rs = getstore( $url, $file ) or die "cannot download to $file ($!)";
      #                   if(!is_success($rs)) { die "unsuccessful download of $url ($!)"; }
    }

    sub download_with_curl() {
      my $self = shift;
      my $url = shift;
      my $file = shift;
      print "> downloading $url with curl\n" if($self->verbose);
      $self->execute_command("curl $url -o $file");
    }

    sub download_with_wget() {
      my $self = shift;
      my $url = shift;
      my $file = shift;
      print "> downloading $url with wget\n" if($self->verbose);
      $self->execute_command("wget $url");
    }

		# downloads the source package
    sub download_src {
        my $self = shift;
			  print "> downloading source for " . $self->name ."\n" if($self->verbose);
        my $url = $self->url;
        my $file = $self->src_file;

  			$self->chdir_to($self->sandbox_dir);

				if( -e $file ) {
					 print "> $file exists, not downloading\n" if($self->verbose);
				}
				else { # lets download

					print "> downloading $url into $file\n" if($self->verbose);

          if( $self->check_command("wget") )
          {
            $self->download_with_wget( $url, $file );
            if( -e $file ) {  return; }
            else
            { print "> failed download with wget ...\n"; }
          }

          if( $self->check_command("curl") )
          {
            $self->download_with_curl( $url, $file );
            if( -e $file ) {  return; }
            else
            { print "> failed download with curl ...\n"; }
          }

          # check we can use LWP
          eval { require LWP; LWP->import(); };
          unless($@) {
            $self->download_with_lwp( $url, $file );
            if( -e $file ) {  return; }
            else
            { print "> failed download with LWP ...\n"; }
          }

  				die "could not download file - $file" if( ! -e $file );
			 }
    }
    
		# check consistency of src package
		sub check_src {
			my $self = shift;
            print "> checking source package consistency for " . $self->name ."\n" if($self->verbose);

            my $checked = 0;            
            
            $checked = 1 if( $self->md5() and $self->check_md5() );
            $checked = 1 if( $self->sha1() and $self->check_sha1() );
            
            if($checked) {
                print "> correct checksum for " . $self->name ."\n" if($self->verbose);
            }
            else {
                die "> correct checksum for " . $self->name ."\n";
            }
		}

        # default md5 
        sub md5  { return undef; }

        # default sha1 
        sub sha1 { return undef; }

		# check md5 on the package file
		sub check_md5 {
                my $self = shift;
                print "> md5 check for " . $self->name ."\n" if($self->verbose);
                my $file = $self->src_file;
				my $md5 = $self->md5();
				open(FILE, $file) or die "Can't open '$file': $!";
                binmode(FILE);
                my $computed_md5 = Digest::MD5->new->addfile(*FILE)->hexdigest;
				if ( $md5 eq $computed_md5 ) {
                    print "> $file has correct md5 sum check [$md5]\n" if($self->debug);
                    return 1;
				}
				else { 
                    croak "file '$file' has unexpected md5 sum check: expected [$md5] got [$computed_md5]";
                    return 0;
                }
		}

		# check sha1 on the package file
		sub check_sha1 {
    			my $self = shift;
        		print "> sha1 check for " . $self->name ."\n" if($self->verbose);
                my $file = $self->src_file;
				my $sha1 = $self->sha1();
				open(FILE, $file) or die "Can't open '$file': $!";
                binmode(FILE);
                my $computed_sha1 = Digest::SHA1->new->addfile(*FILE)->hexdigest;
                if ( $sha1 eq $computed_sha1 ) {
                    print "> $file has correct sha1 sum check [$sha1]\n" if($self->debug);
                    return 1;
				}
				else { 
                    croak "file '$file' has unexpected sha1 sum check: expected [$sha1] got [$computed_sha1]";
                    return 0;
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
            my $srcfile = $self->src_file;

            $self->execute_command( "cp $srcfile $srcfile.bak" );  # backup

            my $tar     = $self->which('tar');
            my $gunzip  = $self->which('gunzip');
            my $bunzip2 = $self->which('bunzip2');
            my $unzip   = $self->which('unzip');

            my $success = 0;
            my $output;
            if( defined $tar and defined $gunzip and ( $srcfile =~ /\.tar\.gz$/ or $srcfile =~ /\.tgz$/  ) )
            {
                my $tarfile = $srcfile;
                $tarfile =~ s/\.tar\.gz$/\.tar/;
                unlink( $tarfile ); # remove tar files from previous attempts
                $output = $self->execute_command( "$gunzip  $srcfile" );  print "$output\n" if($self->debug);
                $output = $self->execute_command( "$tar -xf $tarfile" ); print "$output\n" if($self->debug);
                unlink( $tarfile ); # cleanup uncompressed tar file
                $success = 1;
            }

            if( defined $tar and defined $bunzip2 and ( $srcfile =~ /\.tar\.bz2$/ ) )
            {
                my $tarfile = $srcfile;
                $tarfile =~ s/\.tar\.bz2$/\.tar/;
                unlink( $tarfile ); # remove tar files from previous attempts
                $output = $self->execute_command( "$bunzip2 $srcfile" );  print "$output\n" if($self->debug);
                $output = $self->execute_command( "$tar -xf $tarfile" );  print "$output\n" if($self->debug);
                unlink( $tarfile ); # cleanup uncompressed tar file
                $success = 1;
            }

            if( defined $unzip and ( $srcfile =~ /\.zip$/ ) )
            {
                $output = $self->execute_command( "$unzip $srcfile" ); print "$output\n" if($self->debug);
                $success = 1;
            }

            die "could not uncompress file: $srcfile" if( $success eq 0 );

            $self->execute_command( "mv $srcfile.bak $srcfile" );  # restore the backup

            print "$output\n" if($self->debug);
            return;
        }

		# configure the package for building
		sub configure {
			my $self = shift;
			print "> configure build of " . $self->name ."\n" if ($self->verbose);
            my $bdir = $self->build_dir;
            mkpath $bdir unless( -e $bdir );            
			$self->chdir_to($bdir);
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
			return "make -j3";
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
			print "> cleaning up sandbox " . $self->build_dir ."\n" if($self->verbose);
			$self->chdir_to($self->sandbox_dir);
			rmtree( $self->build_dir );
            if( $self->source_dir ne $self->build_dir )
            {
               rmtree( $self->source_dir );
            }
		}

		# hook for prebuild
		sub setup_variables {
            my $self = shift;
            if ( exists $ENV{CC} ) {
                print ">>> detected environment variable for C compiler -- CC = '".$ENV{CC}."'\n" if($self->verbose);
            }
			if ( exists $ENV{CXX} )	{
                print ">>> detected environment variable for C++ compiler -- CXX = '".$ENV{CXX}."'\n" if($self->verbose);
            }
        }

		# list of packages of which it depends
		sub depends { return (); }

		# hook for prebuild
		sub pre_build {}

		# hook for postbuild
		sub post_build {}

		# installs the package
		sub cook {
			my $self = shift;

			$self->pre_build();

			$self->setup_variables();

			$self->download_src();

			$self->check_src();
            
			$self->unpack_src();

			$self->configure();

			$self->build();

			$self->install();

			$self->cleanup();

			$self->post_build();
		}

1;  # close package Recipe
