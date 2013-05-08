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
    sub version    { return "3.1.2"; }
    sub url        { return "http://www.mpfr.org/mpfr-current/mpfr-3.1.2.tar.gz"; }

    sub md5   { return "181aa7bb0e452c409f2788a4a7f38476"; }    
    sub sha1  { return "5ef83b835fe0a8bf29b7929394633252673e0d67"; }    

1;
