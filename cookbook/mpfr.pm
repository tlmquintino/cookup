# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package mpfr;

use strict;
use warnings;

use Recipe;

my %fields = (
    name     => "mpfr",
    version  => "3.1.0",
    url      => "http://www.mpfr.org/mpfr-current/mpfr-3.1.0.tar.gz",
	md5      => "10968131acc26d79311ac4f8982ff078",
);

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

1;
