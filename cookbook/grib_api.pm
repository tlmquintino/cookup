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
			return "./configure --prefix=" . $self->prefix;
		}

1; 
