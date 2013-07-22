# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package cmake;

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

    sub name       { return "cmake"; }
    sub version    { return "2.8.11.2"; }
    sub url        { return "http://www.cmake.org/files/v2.8/cmake-2.8.11.2.tar.gz"; }

    sub md5   { return "6f5d7b8e7534a5d9e1a7664ba63cf882"; }
    sub sha1  { return "31f217c9305add433e77eff49a6eac0047b9e929"; }

	sub configure_command {
		my $self = shift;
		return "./bootstrap --prefix=" . $self->prefix;
	}

1;
