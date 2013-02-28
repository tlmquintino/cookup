# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package glog;

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

    sub name       { return "glog"; }
    sub version    { return "0.3.2"; }
    sub url        { return "http://google-glog.googlecode.com/files/glog-0.3.2.tar.gz"; }

    sub md5  { return "897fbff90d91ea2b6d6e78c8cea641cc"; }
    sub sha1 { return "94e641e50afd03c574af6a55084e94a347c911d7"; }

1;
