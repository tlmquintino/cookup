# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package gperftools;

use strict;
use warnings;

use Recipe;

my %fields = (
    name     => "gperftools",
    version  => "2.0",
	url      => "http://gperftools.googlecode.com/files/gperftools-2.0.tar.gz",
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

    sub md5  { return "13f6e8961bc6a26749783137995786b6"; }    

1;
