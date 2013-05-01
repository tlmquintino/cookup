# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package metis;

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

    sub depends { return qw( cmake ); }

    sub name       { return "metis"; }
    sub version    { return "5.1.0"; }
    sub url        { return "http://glaros.dtc.umn.edu/gkhome/fetch/sw/metis/metis-5.1.0.tar.gz"; }

    sub md5  { return "5465e67079419a69e0116de24fce58fe"; }    
    sub sha1 { return "4722c647024271540f2adcf83456ebdeb1b7d6a6"; }    

    sub configure_command {
      my $self = shift;
      return "make config shared=1 prefix=" . $self->prefix;
    }

1;
