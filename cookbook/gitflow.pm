# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package git;

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

    sub name       { return "git"; }
    sub version    { return "1.8.4"; }
    sub url        { return "http://git-core.googlecode.com/files/git-1.8.4.tar.gz"; }
        
    sub md5  { return "355768a1c70d0cb4fedf4b598ac1375b"; }
    sub sha1 { return "2a361a2d185b8bc604f7f2ce2f502d0dea9d3279"; }

1;
