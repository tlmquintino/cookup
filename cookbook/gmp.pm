package gmp;

use strict;
use warnings;

use Recipe;

my %fields = (
    name     => "gmp",
    version  => "5.0.3",
    url      => "http://ftp.gnu.org/gnu/gmp/gmp-5.0.3.tar.bz2",
	md5      => "8061f765cc86b9765921a0c800615804",
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

1;
