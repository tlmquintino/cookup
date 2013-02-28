# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package bison;

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

    sub name       { return "bison"; }
    sub version    { return "2.5"; }
    sub url        { return "http://ftp.gnu.org/gnu/bison/bison-2.5.tar.gz"; }
    
    sub md5  { return "687e1dcd29452789d34eaeea4c25abe4"; }
    sub sha1 { return "645ebfc884e5b98d5dd2060af16353959537e895"; }

    sub depends { return qw( m4 ); }
    
1;
