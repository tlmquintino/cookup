package flex;

use strict;
use warnings;

use Recipe;

my %fields = (
    name     => "flex",
    version  => "2.5.35",
		url      => "http://download.sourceforge.net/flex/flex-2.5.35.tar.gz",
		md5      => "201d3f38758d95436cbc64903386de0b",
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
