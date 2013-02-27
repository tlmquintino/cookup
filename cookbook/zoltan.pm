# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package zoltan;

use strict;
use warnings;

use Recipe;

my %fields = (
    name     => "",
    version  => "",
    url      => "",
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

    sub depends { return qw( cmake parmetis ); }

    sub name       { return "zoltan"; }
    sub version    { return "3.6"; }
    sub url        { return "http://trilinos.sandia.gov/download/files/trilinos-10.12.1-Source.tar.gz"; }

    sub md5  { return "9bacdb888efc21986344b3f61ac845a8"; }
    sub sha1 { return "d032de499a5cb87abb739c8ec9ed1369bb97d297"; }

    sub source_dir {
        my $self = shift;
        return sprintf "%s/%s", $self->sandbox_dir,"trilinos-10.12.1-Source";
    }

    sub build_dir {
        my $self = shift;
        return sprintf "%s/%s", $self->source_dir,"zoltan_build";
    }

    sub configure_command {
      my $self = shift;
      return "cmake"
        ." -DCMAKE_INSTALL_PREFIX=".$self->prefix
        ." -DBUILD_SHARED_LIBS:BOOL=ON"
        ." -DTrilinos_VERBOSE_CONFIGURE:BOOL=OFF"
        ." -DTrilinos_ENABLE_Fortran:BOOL=OFF"
        ." -DTrilinos_ENABLE_EXAMPLES:BOOL=OFF"
        ." -DTrilinos_ENABLE_ALL_PACKAGES:BOOL=OFF"
        ." -DTrilinos_ENABLE_Zoltan:BOOL=ON"
        ." -DTPL_ENABLE_MPI:BOOL=ON"
        ." -DZoltan_ENABLE_ULLONG_IDS:Bool=ON"
        ." -DZoltan_ENABLE_EXAMPLES:BOOL=OFF"
        ." -DZoltan_ENABLE_TESTS:BOOL=OFF"
        ." -DZoltan_ENABLE_ParMETIS:BOOL=ON"
        ." ../";
    }

1;
