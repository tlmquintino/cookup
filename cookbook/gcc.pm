# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.
# In applying this licence, ECMWF does not waive the privileges and immunities
# granted to it by virtue of its status as an intergovernmental organisation nor
# does it submit to any jurisdiction.

package gcc;

use strict;
use warnings;

use Recipe;

my %fields = (
    name     => "gcc",
    version  => "4.6.2",
    url      => "http://ftp.gnu.org/gnu/gcc/gcc-4.6.2/gcc-4.6.2.tar.gz",
	md5      => "56c5b2a0ca0d4f27a827548ce5cf4203",
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

1;
