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
    sub version    { return "1.8.0"; }
    sub url        { return "http://git-core.googlecode.com/files/git-1.8.0.tar.gz"; }
        
    sub md5  { return "12f4d20f34ae37086d86dd3b9d037bba"; }
    sub sha1 { return "a03afc33f8f0723ad12649d79f1e8968526b4bf7"; }

1;
