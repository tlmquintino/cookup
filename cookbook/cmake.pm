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
    sub version    { return "2.8.8"; }
    sub url        { return "http://www.cmake.org/files/v2.8/cmake-2.8.8.tar.gz"; }
    
    sub md5  { return "ba74b22c788a0c8547976b880cd02b17"; }    

	sub configure_command {
		my $self = shift;
		return "./bootstrap --prefix=" . $self->prefix;
	}

1;
