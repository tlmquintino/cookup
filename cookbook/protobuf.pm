# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package protobuf;

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

    sub name       { return "protobuf"; }
    sub version    { return "2.5.0"; }
    sub url        { return "http://protobuf.googlecode.com/files/protobuf-2.5.0.tar.gz"; }

    sub md5  { return "b751f772bdeb2812a2a8e7202bf1dae8"; }
    sub sha1 { return "7f6ea7bc1382202fb1ce8c6933f1ef8fea0c0148"; }

1;
