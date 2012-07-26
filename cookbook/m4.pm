# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package m4;

use strict;
use warnings;

use Recipe;

my %fields = (
    name     => "m4",
    version  => "1.4.16",
	url      => "http://ftp.gnu.org/gnu/m4/m4-1.4.16.tar.gz",
	md5      => "a5dfb4f2b7370e9d34293d23fd09b280",
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
