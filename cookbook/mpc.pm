package mpc;

use strict;
use warnings;

use Recipe;

my %fields = (
    name     => "mpc",
    version  => "0.9",
    url      => "http://www.multiprecision.org/mpc/download/mpc-0.9.tar.gz",
	md5      => "0d6acab8d214bd7d1fbbc593e83dd00d",
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
