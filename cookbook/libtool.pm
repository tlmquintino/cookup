# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package libtool;

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

    sub name       { return "libtool"; }
    sub version    { return "2.4.2"; }
    sub url        { return "http://ftpmirror.gnu.org/libtool/libtool-2.4.2.tar.gz"; }

    sub md5  { return "d2f3b7d4627e69e13514a40e72a24d50"; }    

1;
