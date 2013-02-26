# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package jemalloc;

use strict;
use warnings;

use Recipe;

my %fields = ();

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

    sub name       { return "jemalloc"; }
    sub version    { return "3.0.0"; }
    sub url        { return "http://www.canonware.com/download/jemalloc/jemalloc-3.0.0.tar.bz2"; }

    sub md5  { return "f487fdf847c9834b22c2b7832cadc56f"; }
    sub sha1 { return "65a66bd1b54ffdd56f5024b45df19d40d6e6f9dd"; }

1;
