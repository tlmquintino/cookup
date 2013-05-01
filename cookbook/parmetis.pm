# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package parmetis;

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

    sub depends { return qw( cmake openmpi metis ); }

    sub name       { return "parmetis"; }
    sub version    { return "4.0.3"; }
    sub url        { return "http://glaros.dtc.umn.edu/gkhome/fetch/sw/parmetis/parmetis-4.0.3.tar.gz"; }

    sub md5  { return "f69c479586bf6bb7aff6a9bc0c739628"; }    
    sub sha1 { return "e0df69b037dd43569d4e40076401498ee5aba264"; }    

    sub configure_command {
      my $self = shift;
      return "make config shared=1 prefix=".$self->prefix;
    }

1;
