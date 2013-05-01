# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package zlib;

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

    sub name       { return "zlib"; }
    sub version    { return "1.2.8"; }
    sub url        { return "http://zlib.net/zlib-1.2.8.tar.gz"; }

    sub md5  { return "44d667c142d7cda120332623eab69f40"; }
    sub sha1 { return "a4d316c404ff54ca545ea71a27af7dbc29817088"; }

1;
