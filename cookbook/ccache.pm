# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package ccache;

use strict;
use warnings;

use Recipe;

my %fields = (
    name     => "ccache",
    version  => "3.1.7",
		url      => "http://samba.org/ftp/ccache/ccache-3.1.7.tar.gz",
		md5      => "bf49574730fabd666fc7ec3f8b203f41",
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
