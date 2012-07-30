# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package glog;

use strict;
use warnings;

use Recipe;

my %fields = (
    name     => "glog",
    version  => "0.3.2",
	url      => "http://google-glog.googlecode.com/files/glog-0.3.2.tar.gz",
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

    sub md5  { return "897fbff90d91ea2b6d6e78c8cea641cc"; }    

1;
