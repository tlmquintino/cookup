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
    sub version    { return "1.8.3.1"; }
    sub url        { return "http://git-core.googlecode.com/files/git-1.8.3.1.tar.gz"; }
        
    sub md5  { return "35401b410e7f248b13e35a1069aca2e2"; }
    sub sha1 { return "32562a231fe4422bc033bf872fffa61f41ee2669"; }

1;
