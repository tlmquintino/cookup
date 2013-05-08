# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package eigen;

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

    sub depends { return qw( cmake metis superlu ); }

    sub name    { return "eigen"; }
    sub version { return "3.1.3"; }
    sub url     { return "http://bitbucket.org/eigen/eigen/get/3.1.3.tar.bz2"; }
    sub md5     { return "43eee0e9252a77149d6b65e93e73b79d"; }
    sub sha1    { return "07e248deaaa5d2a8822a0581a606151127fce450"; }

    sub package_dir { return "eigen-eigen-2249f9c22fe8"; }

    sub build_dir {
        my $self = shift;
        return sprintf "%s/%s", $self->source_dir,"build";
    }

    sub configure_command {

      my $self = shift;
      return "cmake "
        ." -DCMAKE_PREFIX_PATH=".$self->root_prefix()
        ." -DCMAKE_INSTALL_PREFIX=".$self->prefix()
        ." ../";
    }

1;
