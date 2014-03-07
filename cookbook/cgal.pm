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
    sub version    { return "4.3"; }
    sub url        { return "https://gforge.inria.fr/frs/download.php/32994/CGAL-4.3.tar.gz"; }

    sub md5  { return "3fa2d43adbf5c05d76c5ec01f5033cc9"; }
    sub sha1 { return "035d5fd7657e9eeccfc46ff0ebf84f137e63b03a"; }
    
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
        ." -DCMAKE_PREFIX_PATH=".$self->root_prefix()
        ." -DCMAKE_INSTALL_PREFIX=".$self->prefix();
    }

1;
