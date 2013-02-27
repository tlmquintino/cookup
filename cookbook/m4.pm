# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package m4;

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

    sub name       { return "m4"; }
    sub version    { return "1.4.16"; }
    sub url        { return "http://ftp.gnu.org/gnu/m4/m4-1.4.16.tar.gz"; }
    
    sub md5  { return "a5dfb4f2b7370e9d34293d23fd09b280"; }
    sub sha1 { return "44b3ed8931f65cdab02aee66ae1e49724d2551a4"; }

1;
