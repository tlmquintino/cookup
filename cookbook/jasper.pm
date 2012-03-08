# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.
# In applying this licence, ECMWF does not waive the privileges and immunities
# granted to it by virtue of its status as an intergovernmental organisation nor
# does it submit to any jurisdiction.

package jasper;

use strict;
use warnings;

use Recipe;

my %fields = (
    name     => "jasper",
    version  => "1.900.1",
		url      => "http://www.ece.uvic.ca/~frodo/jasper/software/jasper-1.900.1.zip",
		md5      => "a342b2b4495b3e1394e161eb5d85d754",
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
