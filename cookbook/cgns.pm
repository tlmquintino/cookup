# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package cgns;

use strict;
use warnings;

use Recipe;

my %fields = (
    name     => "cgns",
    version  => "3.1.3",
    url      => "http://downloads.sourceforge.net/project/cgns/cgnslib_3.1/cgnslib_3.1.3-4.tar.gz",
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
    
    sub md5  { return "442bba32b576f3429cbd086af43fd4ae"; }
    
    sub depends { return qw( hdf5 cmake ); }

    sub source_dir {
        my $self = shift;
        return sprintf "%s/%s", $self->sandbox_dir,"cgnslib_3.1.3";
    }

    sub build_dir {
        my $self = shift;
        return sprintf "%s/%s", $self->source_dir,"build";
    }

    sub configure_command {
      my $self = shift;
      return "cmake "
        ." -DCMAKE_INSTALL_PREFIX=".$self->prefix
        ." -DENABLE_FORTRAN=NO"
        ." -DENABLE_HDF5=YES"
        ." -DHDF5_NEED_ZLIB=YES"
        ." -DHDF5_NEED_MPI=YES"
        ." -DCMAKE_SHARED_LINKER_FLAGS=-lhdf5"
        ." -DCMAKE_EXE_LINKER_FLAGS=-lhdf5"
        ." -DHDF5_INCLUDE_PATH:PATH=" . $self->prefix . "/include"
        ." -BUILD_CGNSTOOLS:BOOL=YES"
        ." ../";
    }

1;
