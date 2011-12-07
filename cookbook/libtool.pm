package libtool;

use strict;
use warnings;

use Recipe;

my %fields = (
    name     => "libtool",
    version  => "2.4.2",
		url      => "http://ftpmirror.gnu.org/libtool/libtool-2.4.2.tar.gz",
		md5      => "d2f3b7d4627e69e13514a40e72a24d50",
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
