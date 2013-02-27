# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package ccache;

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

    sub name       { return "ccache"; }
    sub version    { return "3.1.7"; }
    sub url        { return "http://samba.org/ftp/ccache/ccache-3.1.7.tar.gz"; }

    sub md5  { return "bf49574730fabd666fc7ec3f8b203f41"; }
    sub sha1 { return "93872fb20c066859842e4bc989895359ae218ad6"; }
1;
