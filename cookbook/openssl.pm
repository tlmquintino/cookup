package openssl;

use strict;
use warnings;

use Recipe;

my %fields = (
    name     => "openssl",
    version  => "1.0.0e",
		url      => "http://www.openssl.org/source/openssl-1.0.0e.tar.gz",
		md5      => "7040b89c4c58c7a1016c0dfa6e821c86",
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
