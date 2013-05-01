# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package openmpi;

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

    sub name       { return "openmpi"; }
    sub version    { return "1.6.4"; }
    sub url        { return "http://www.open-mpi.org/software/ompi/v1.6/downloads/openmpi-1.6.4.tar.gz"; }

    sub md5   { return "70aa9b6271d904c6b337ca326e6613d1"; }    
    sub sha1  { return "3acfe95f80b19a11b300cae40ce6649dff6df5cf"; }    

	sub configure_command {
		my $self = shift;
		return "./configure --disable-visibility --without-cs-fs --with-threads=posix --prefix=" . $self->prefix;
	}
            
1;
