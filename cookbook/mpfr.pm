# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package mpfr;

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
    
	sub depends { return qw( gmp ); }

    sub name       { return "mpfr"; }
    sub version    { return "3.1.1"; }
    sub url        { return "http://www.mpfr.org/mpfr-current/mpfr-3.1.1.tar.gz"; }

    sub md5   { return "769411e241a3f063ae1319eb5fac2462"; }    
    sub sha1  { return "8b7e35d244ee4d4144cb8d4d17b0c5ba7288dff4"; }    

1;
