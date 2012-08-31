# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package cgal;

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
    
    sub name       { return "cgal"; }
    sub version    { return "4.0.2"; }
    sub url        { return "https://gforge.inria.fr/frs/download.php/31175/CGAL-4.0.2.tar.gz"; }

    sub md5  { return "d0d1577f72fc8ab49fed3d966dae19da"; }
    sub sha1 { return "e80af4b1da25690df63ce83dd083710cc3db9697"; }
    
    sub depends { return qw( boost ); }

    sub source_dir {
        my $self = shift;
        return sprintf "%s/%s", $self->sandbox_dir,"CGAL-".$self->version();
    }

    sub build_dir {
        my $self = shift;
        return sprintf "%s/%s", $self->source_dir,"build";
    }

    sub configure_command {
      my $self = shift;
      return "cmake .. "
        ." -DCMAKE_PREFIX_PATH=".$self->prefix
        ." -DCMAKE_INSTALL_PREFIX=".$self->prefix;
    }

1;
