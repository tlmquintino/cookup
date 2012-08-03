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
    sub version    { return "1.9.16"; }
    sub url        { return "http://www.ecmwf.int/products/data/software/download/software_files/grib_api-1.9.16.tar.gz"; }
    
    sub md5  { return "f1288627031c97fa1631fd5a63e3bbb3"; }         
    sub sha1 { return "fd85e8b939231d4d8f9dc3131fa0aab73fbbcf78"; } 

    sub configure_command {
        my $self = shift;
        my $fopts = "--disable-fortran";
        if ( exists $ENV{'FC'} or exists $ENV{'F77'} ) {
            $fopts = "" ; # don't say anything as it is the default
        }
		return "./configure --disable-jpeg $fopts CFLAGS='-fPIC' --prefix=" . $self->prefix;
	}

1;
