# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package gcc;

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

	sub depends { return qw( mpc ); }

    sub name       { return "gcc"; }
    sub version    { return "4.8.1"; }
    sub url        { return "http://ftp.gnu.org/gnu/gcc/gcc-4.7.1/gcc-4.8.1.tar.gz"; }
    
    sub md5   { return "74cc12b7afe051ab7d0e00269e49fc9b"; }
    sub sha1  { return "6a0e87e73f7dc07317744404fdc4fe92c99ff5ee"; }

    sub configure_command {
		my $self = shift;
		return "./configure --enable-languages=c,c++,fortran".
                   " --with-gmp=".$self->root_prefix().
                   " --with-mpfr=".$self->root_prefix().
                   " --with-mpc=".$self->root_prefix().
                   " --prefix=" . $self->prefix;
	}
        
1;
