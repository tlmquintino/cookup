# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package zlib;

use strict;
use warnings;

use Recipe;

my %fields = (
    name     => "zlib",
    version  => "1.2.7",
    url      => "http://zlib.net/zlib-1.2.7.tar.gz",
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

    sub md5  { return "60df6a37c56e7c1366cca812414f7b85"; }

1;
