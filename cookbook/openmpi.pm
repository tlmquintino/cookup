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
    sub version    { return "1.6.3"; }
    sub url        { return "http://www.open-mpi.org/software/ompi/v1.6/downloads/openmpi-1.6.3.tar.gz"; }

    sub md5   { return "c8865d7ce14594e168851787223182f4"; }    
    sub sha1  { return "80e859dee8f2fa13f5eb511c9062e9a2fc14c488"; }    

	sub configure_command {
		my $self = shift;
		return "./configure --disable-visibility --without-cs-fs --with-threads=posix --prefix=" . $self->prefix;
	}
            
1;
