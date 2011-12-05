package Recipe;

use strict;
use warnings;

use Carp;
use LWP::Simple; 
use File::Basename; 
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
        confess "usage: thing->debug(level)" unless @_ == 1;
        my $level = shift;
        if (ref($self))  {
            $self->{"debug_"} = $level;
        } else {
            $debugging_ = $level;            # whole class
        }
        $self->SUPER::debug($level);
    }

###############################################################################
## public methods

    sub package {
        my $self = shift;
				my $pname = $self->package_name;
				if($pname) { return $pname; }
        return sprintf "%s-%s", $self->name(), $self->version();
    }

    sub install {
        my $self = shift;
        my $type = ref($self);
        my $package = $self->package();
        croak "Recipe '$type' for package '$package' does not have an install method defined";
    }

		sub src_file { # get the source file name from the url
        my $self = shift;
				return basename($self->url);
		}

    sub download_file {
        my $self = shift;
        my $url = shift;
        my $file = $self->src_file;
				if($debugging_) { print "downloading $url into $file\n" };
				getstore( $url, $file );	
    }

    sub download_src {
        my $self = shift;
				$self->download_file( $self->url, $self->src_file() );	
    }

1;  # close package Recipe
