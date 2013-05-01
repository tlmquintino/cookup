# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package cgns;

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

    sub depends { return qw( hdf5 cmake ); }
    
    sub name       { return "cgns"; }
    sub version    { return "3.1.4"; }
    sub url        { return "http://downloads.sourceforge.net/project/cgns/cgnslib_3.1/cgnslib_3.1.4.tar.gz"; }

    sub md5  { return "6937c7fae34381fd51986bd3d42832cd"; }
    sub sha1 { return "db629371d0166f2f65d6f852fb9cef4ed310ea6b"; }

    sub source_dir {
        my $self = shift;
        return sprintf "%s/%s", $self->sandbox_dir,"cgnslib_3.1.4";
    }

    sub build_dir {
        my $self = shift;
        return sprintf "%s/%s", $self->source_dir,"build";
    }

    sub configure_command {
      my $self = shift;
      return "cmake "
        ." -DENABLE_FORTRAN=NO"
        ." -DENABLE_HDF5=YES"
        ." -DHDF5_NEED_ZLIB=YES"
        ." -DHDF5_NEED_MPI=YES"
        ." -DCMAKE_PREFIX_PATH=".$self->prefix
        ." -DCMAKE_INSTALL_PREFIX=".$self->prefix
        ." -BUILD_CGNSTOOLS:BOOL=YES"
        ." ../";
    }

1;
