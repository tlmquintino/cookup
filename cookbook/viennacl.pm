# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package viennacl;

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
    
    sub name       { return "viennacl"; }
    sub version    { return "1.4.2"; }
    sub url        { return "http://download.sourceforge.net/viennacl/ViennaCL-1.4.2.tar.gz"; }

    sub md5  { return "998825f7b0c8624d3df4810c5f687af1"; }
    sub sha1 { return "62842f33524238ea8a1b1737480c7524ff27f95b"; }
    
    # sub depends { return qw( boost ); }

    sub source_dir {
        my $self = shift;
        return sprintf "%s/%s", $self->sandbox_dir,"ViennaCL-".$self->version();
    }

    sub build_dir {
        my $self = shift;
        return sprintf "%s/%s", $self->source_dir,"build";
    }

    sub configure_command {
      my $self = shift;
      return "cmake .. "
        ." -DCMAKE_PREFIX_PATH=".$self->root_prefix()
        ." -DCMAKE_INSTALL_PREFIX=".$self->prefix();
    }

1;
