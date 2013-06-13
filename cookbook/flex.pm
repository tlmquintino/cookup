# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package flex;

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

    sub name       { return "flex"; }
    sub version    { return "2.5.37"; }
    sub url        { return "http://download.sourceforge.net/flex/flex-2.5.37.tar.gz"; }
    
    sub md5  { return "6c16fa35ba422bf809effa106d022a39"; }
    sub sha1 { return "034f2da5c9a0ab5a18689fb010ed75008af99c90"; }

1;
