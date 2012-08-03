# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package grib_api;

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

	# sub depends { return qw( jasper libpng ); }

    sub name       { return "grib_api"; }
    sub version    { return "1.9.9"; }
    sub url        { return "http://www.ecmwf.int/products/data/software/download/software_files/grib_api-1.9.9.tar.gz"; }
    
    sub md5 { return "fe6c684e4a41477f3a6e97ab8892f35d"; }

    sub configure_command {
        my $self = shift;
        my $fopts = "--disable-fortran";
        if ( exists $ENV{'FC'} or exists $ENV{'F77'} ) {
            $fopts = "--enable-fortran"
        }
		return "./configure --disable-jpeg $fopts CFLAGS='-fPIC' --prefix=" . $self->prefix;
	}

1;
