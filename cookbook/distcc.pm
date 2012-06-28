# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package distcc;

use strict;
use warnings;

use Recipe;

my %fields = (
    name     => "distcc",
    version  => "3.1",
		url      => "http://distcc.googlecode.com/files/distcc-3.1.tar.gz",
		md5      => "2f6be779869648f2d211ebf09f694715",
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

1;
