# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.
# In applying this licence, ECMWF does not waive the privileges and immunities
# granted to it by virtue of its status as an intergovernmental organisation nor
# does it submit to any jurisdiction.

package grib_api;

use strict;
use warnings;

use Recipe;

my %fields = (
    name     => "grib_api",
    version  => "1.9.9",
		url      => "http://www.ecmwf.int/products/data/software/download/software_files/grib_api-1.9.9.tar.gz",
		md5      => "fe6c684e4a41477f3a6e97ab8892f35d",
#   requires => "jasper,libpng"
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

		sub configure_command {
			my $self = shift;
			# TODO: should check here for variants of the build
			return "./configure --disable-jpeg --disable-fortran CFLAGS='-fPIC' --prefix=" . $self->prefix;
		}

1;
