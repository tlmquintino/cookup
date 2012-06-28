# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package jemalloc;

use strict;
use warnings;

use Recipe;

my %fields = (
    name     => "jemalloc",
    version  => "3.0.0",
		url      => "http://www.canonware.com/download/jemalloc/jemalloc-3.0.0.tar.bz2",
		md5      => "f487fdf847c9834b22c2b7832cadc56f",
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
