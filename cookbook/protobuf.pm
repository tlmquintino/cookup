# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package protobuf;

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

    sub name       { return "protobuf"; }
    sub version    { return "2.4.1"; }
    sub url        { return "http://protobuf.googlecode.com/files/protobuf-2.4.1.tar.gz"; }

    sub md5  { return "dc84e9912ea768baa1976cb7bbcea7b5"; }
    sub sha1 { return "efc84249525007b1e3105084ea27e3273f7cbfb0"; }

1;
