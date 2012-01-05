package git;

use strict;
use warnings;

use Recipe;

my %fields = (
    name     => "git",
    version  => "1.7.8.2",
		url      => "http://git-core.googlecode.com/files/git-1.7.8.2.tar.gz",
		md5      => "f9def92c4afb708f69006da841502b80",
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
