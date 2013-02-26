## © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package jasper;

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

    sub name       { return "jasper"; }
    sub version    { return "1.900.1"; }
    sub url        { return "http://www.ece.uvic.ca/~frodo/jasper/software/jasper-1.900.1.zip"; }

    sub md5  { return "a342b2b4495b3e1394e161eb5d85d754"; }
    sub sha1 { return "9c5735f773922e580bf98c7c7dfda9bbed4c5191"; }

1;
