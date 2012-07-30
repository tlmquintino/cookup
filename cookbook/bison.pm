# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package bison;

use strict;
use warnings;

use Recipe;

my %fields = (
    name     => "bison",
    version  => "2.5",
    url      => "http://ftp.gnu.org/gnu/bison/bison-2.5.tar.gz",
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

	sub depends { return qw( m4 ); }
    
    sub md5  { return "687e1dcd29452789d34eaeea4c25abe4"; }    

1;
