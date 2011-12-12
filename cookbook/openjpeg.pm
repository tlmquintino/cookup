package openjpeg;

use strict;
use warnings;

use Recipe;

my %fields = (
    name     => "openjpeg",
    version  => "1.4.0",
		url      => "http://openjpeg.googlecode.com/files/openjpeg_v1_4_sources_r697.tgz",
		md5      => "7870bb84e810dec63fcf3b712ebb93db",
		package_dir => "openjpeg_v1_4_sources_r697",
# require => qw( cmake ),
);

our @ISA = ("Recipe");

    sub new 
		{
        my $class = shift;
        my $self  = $class->SUPER::new();
        my($element);
        foreach $element (keys %fields) {
            $self->{_permitted}->{$element} = $fields{$element};
        }
        @{$self}{keys %fields} = values %fields;
        return $self;
    }

		sub configure_command {
			my $self = shift;
			return "cmake -DCMAKE_INSTALL_PREFIX=" . $self->prefix;
		}

1; 
