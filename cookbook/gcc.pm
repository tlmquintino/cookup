# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package gcc;

use strict;
use warnings;

use Recipe;

my %fields = (
    name     => "gcc",
    version  => "4.7.1",
    url      => "http://ftp.gnu.org/gnu/gcc/gcc-4.7.1/gcc-4.7.1.tar.gz",
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
			return "./configure --enable-languages=c,c++,fortran".
                   " --with-gmp=".$self->prefix.
                   " --with-mpfr=".$self->prefix.
                   " --with-mpc=".$self->prefix.
                   " --prefix=" . $self->prefix;
		}
        
	sub depends { return qw( mpc ); }

    sub md5   { return "3d06e24570635c91eed6b114687513a6"; }    
    sub sha1  { return "d13d669fcc8e44a2c35bbb0e68bbb00642af427f"; }    

1;
