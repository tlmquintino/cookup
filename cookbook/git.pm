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
    sub version    { return "1.7.12"; }
    sub url        { return "http://git-core.googlecode.com/files/git-1.7.12.tar.gz"; }
        
    sub md5  { return "ceb1a6b17a3e33bbc70eadf8fce5876c"; }
    sub sha1 { return "42ec1037f1ee5bfeb405710c83b73c0515ad26e6"; }

1;
