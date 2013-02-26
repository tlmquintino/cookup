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
    sub version    { return "0.9"; }
    sub url        { return "http://www.multiprecision.org/mpc/download/mpc-0.9.tar.gz"; }
    
    sub md5  { return "0d6acab8d214bd7d1fbbc593e83dd00d"; }
    sub sha1 { return "229722d553030734d49731844abfef7617b64f1a"; }

1;
