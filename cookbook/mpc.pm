# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package mpc;

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

    sub depends { return qw( mpfr ); }

    sub name       { return "mpc"; }
    sub version    { return "1.0.1"; }
    sub url        { return "http://www.multiprecision.org/mpc/download/mpc-1.0.1.tar.gz"; }
    
    sub md5  { return "b32a2e1a3daa392372fbd586d1ed3679"; }
    sub sha1 { return "8c7e19ad0dd9b3b5cc652273403423d6cf0c5edf"; }

1;
