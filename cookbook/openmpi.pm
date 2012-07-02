# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package openmpi;

use strict;
use warnings;

use Recipe;

my %fields = (
    name     => "openmpi",
    version  => "1.6",
		url      => "http://www.open-mpi.org/software/ompi/v1.6/downloads/openmpi-1.6.tar.gz",
		md5      => "3ed0c892a0c921270cb9c7af2fdfd2d2",
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

		# string for the configure command
		sub configure_command {
			my $self = shift;
			return "./configure --disable-visibility --without-cs-fs --with-threads=posix --prefix=" . $self->prefix;
		}
        
1;
