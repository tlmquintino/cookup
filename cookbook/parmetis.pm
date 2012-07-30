# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package parmetis;

use strict;
use warnings;

use Recipe;

my %fields = (
    name     => "parmetis",
    version  => "4.0.2",
    url      => "http://glaros.dtc.umn.edu/gkhome/fetch/sw/parmetis/parmetis-4.0.2.tar.gz",
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

    sub md5  { return "0912a953da5bb9b5e5e10542298ffdce"; }    

    # string for the configure command
    sub configure_command {
      my $self = shift;
      return "make config shared=1 prefix=" . $self->prefix;
    }

    # Dependencies
    sub depends { return qw( cmake openmpi ); }

1;
