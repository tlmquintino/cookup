# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package hdf5;

use strict;
use warnings;

use Recipe;

my %fields = (
    name     => "hdf5",
    version  => "1.8.9",
	url      => "http://www.hdfgroup.org/ftp/HDF5/current/src/hdf5-1.8.9.tar.gz",
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
    
    sub md5  { return "d1266bb7416ef089400a15cc7c963218"; }
    sub sha1 { return "4ba3ede947b1571e9586fdeb8351d6585a56133c"; }
    
	sub depends { return qw( openmpi zlib ); }

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
