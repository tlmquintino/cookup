## © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package gmp;

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

    sub name       { return "gmp"; }
    sub version    { return "5.0.3"; }
    sub url        { return "http://ftp.gnu.org/gnu/gmp/gmp-5.0.3.tar.bz2"; }
    
    sub md5  { return "8061f765cc86b9765921a0c800615804"; }    

1;
