# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package distcc;

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
    
    sub name       { return "distcc"; }
    sub version    { return "3.1"; }
    sub url        { return "http://distcc.googlecode.com/files/distcc-3.1.tar.gz"; }

    sub md5  { return "2f6be779869648f2d211ebf09f694715"; }
    sub sha1 { return "487ae2a73b0b1a0e6b240874319ca3ddda7287e8"; }

1;
