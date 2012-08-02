# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package openssl;

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

    sub name       { return "openssl"; }
    sub version    { return "1.0.0e"; }
    sub url        { return "http://www.openssl.org/source/openssl-1.0.0e.tar.gz"; }

    sub md5  { return "7040b89c4c58c7a1016c0dfa6e821c86"; }    

	sub configure_command {
		my $self = shift;
		return "./config --prefix=" . $self->prefix;
	}

1;
