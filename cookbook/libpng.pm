package libpng;

use strict;
use warnings;

use Recipe;

my %fields = (
    name     => "libpng",
    version  => "1.5.6",
		url      => "http://download.sourceforge.net/libpng/libpng-1.5.6.tar.gz",
		md5      => "8b0c05ed12637ee1f060ddfbbf526ea3",
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