package bison;

use strict;
use warnings;

use Recipe;

my %fields = (
    name     => "bison",
    version  => "2.5",
		url      => "http://ftp.gnu.org/gnu/bison/bison-2.5.tar.gz",
		md5      => "687e1dcd29452789d34eaeea4c25abe4",
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
