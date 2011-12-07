package jasper;

use strict;
use warnings;

use Recipe;

my %fields = (
    name     => "jasper",
    version  => "1.900.1",
		url      => "http://www.ece.uvic.ca/~frodo/jasper/software/jasper-1.900.1.zip",
		md5      => "a342b2b4495b3e1394e161eb5d85d754",
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
