# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package libxml2;

use strict;
use warnings;

use Recipe;

my %fields = (
    name     => "libxml2",
    version  => "2.8.0",
		url      => "http://xmlsoft.org/sources/libxml2-2.8.0.tar.gz",
		md5      => "c62106f02ee00b6437f0fb9d370c1093",
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
