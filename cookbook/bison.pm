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
    sub version    { return "2.7"; }
    sub url        { return "http://ftp.gnu.org/gnu/bison/bison-2.7.tar.gz"; }
    
    sub md5  { return "ded660799e76fb1667d594de1f7a0da9"; }
    sub sha1 { return "aa4f5aa51ee448bac132041df0ce25a800a3661c"; }

    sub depends { return qw( m4 ); }
    
1;
