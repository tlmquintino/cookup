# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package libpng;

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

    sub name       { return "libpng"; }
    sub version    { return "1.5.6"; }
    sub url        { return "http://download.sourceforge.net/libpng/libpng-1.5.6.tar.gz"; }

    sub md5  { return "8b0c05ed12637ee1f060ddfbbf526ea3"; }
    sub sha1 { return "068d308a82003cbb24602ffdfc738cc848cf4eaf"; }

1;
