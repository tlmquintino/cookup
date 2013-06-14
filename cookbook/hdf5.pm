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
    sub version    { return "1.8.11"; }
    sub url        { return "http://www.hdfgroup.org/ftp/HDF5/current/src/hdf5-1.8.11.tar.gz"; }

    sub md5  { return "1a4cc04f7dbe34e072ddcf3325717504"; }
    sub sha1 { return "6b545eb160b1f12b2ec3a5f2933c414a5702f7d8"; }

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
