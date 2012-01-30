package gcc;

use strict;
use warnings;

use Recipe;

my %fields = (
    name     => "gcc",
    version  => "4.6.2",
    url      => "http://ftp.gnu.org/gnu/gcc/gcc-4.6.2/gcc-4.6.2.tar.gz",
	md5      => "56c5b2a0ca0d4f27a827548ce5cf4203",
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
			return "./configure --enable-languages=c,c++,fortran --prefix=" . $self->prefix;
		}

1;
