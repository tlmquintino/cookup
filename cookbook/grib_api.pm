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
    sub version    { return "1.10.4"; }
    sub url        { return "https://software.ecmwf.int/wiki/download/attachments/3473437/grib_api-1.10.4.tar.gz"; }
    
    sub md5  { return "34ce631af96316441f9e3e8e54ecf719"; }
    sub sha1 { return "2848edccd6f4db64c838f7391e14a5ad7b3d6c44"; }

    sub configure_command {
        my $self = shift;
        my $fopts = "--disable-fortran";
        if ( exists $ENV{'FC'} or exists $ENV{'F77'} ) {
            $fopts = "" ; # don't say anything as it is the default
        }
		return "./configure --disable-jpeg $fopts CFLAGS='-fPIC' --prefix=" . $self->prefix;
	}

1;
