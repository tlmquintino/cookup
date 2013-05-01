# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package hdf5;

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

    sub depends { return qw( openmpi zlib ); }

    sub name       { return "hdf5"; }
    sub version    { return "1.8.10-patch1"; }
    sub url        { return "http://www.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8.10-patch1/src/hdf5-1.8.10-patch1.tar.gz"; }

    sub md5  { return "2147a289fb33c887464ad2b6c5a8ae4c"; }
    sub sha1 { return "66916343f840a7a181ecd53c9ffa2945996c7dfc"; }

    sub pre_build {
        my $self = shift;
        $self->{CC}  = $ENV{CC};
        $self->{CXX} = $ENV{CXX};
        $ENV{CC}   = "mpicc";
        $ENV{CXX}  = "mpic++";
    }

	sub configure_command {
		my $self = shift;
		return "./configure --enable-zlib --enable-linux-lfs --with-gnu-ld --enable-hl --enable-shared --prefix=" . $self->prefix;
	}
        
    sub post_build {
        my $self = shift;
        $ENV{CC}   = $self->{CC};
        $ENV{CXX}  = $self->{CXX};
    }

1;
