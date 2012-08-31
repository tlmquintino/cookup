# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package git_1_7_11_3;

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

    sub version    { return "1.7.11.3"; }
    sub url        { return "http://git-core.googlecode.com/files/git-1.7.11.3.tar.gz"; }
        
    sub md5  { return "23caacd9f3f421b6c05b40796df3505d"; }
    sub sha1 { return "a10c420e4d9152d6059f41825904cfac3062b135"; }

1;
