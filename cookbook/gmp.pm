## © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package gmp;

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

    sub name       { return "gmp"; }
    sub version    { return "5.1.2"; }
    sub url        { return "http://ftp.gnu.org/gnu/gmp/gmp-5.1.2.tar.bz2"; }
    
    sub md5  { return "7e3516128487956cd825fef01aafe4bc"; }
    sub sha1 { return "2cb498322b9be4713829d94dee944259c017d615"; }

1;
