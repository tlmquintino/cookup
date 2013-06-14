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
    sub version    { return "3.4.0"; }
    sub url        { return "http://www.canonware.com/download/jemalloc/jemalloc-3.4.0.tar.bz2"; }

    sub md5  { return "c4fa3da0096d5280924a5f7ebc8dbb1c"; }
    sub sha1 { return "06f572f1cc6a4e4a68c7f9a354f12e17ba32f70b"; }

1;
