# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package readline;

use strict;
use warnings;

use Recipe;

my %fields = (
    name     => "readline",
    version  => "6.2",
	url      => "http://ftp.gnu.org/gnu/readline/readline-6.2.tar.gz",
	md5      => "67948acb2ca081f23359d0256e9a271c",
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
