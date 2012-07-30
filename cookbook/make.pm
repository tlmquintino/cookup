# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package make;

use strict;
use warnings;

use Recipe;

my %fields = (
    name     => "make",
    version  => "3.82",
	url      => "http://ftp.gnu.org/gnu/make/make-3.82.tar.gz",
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

    sub md5   { return "7f7c000e3b30c6840f2e9cf86b254fac"; }    
    sub sha1  { return "92d1b87a30d1c9482e52fb4a68e8a355e7946331"; }    

1;
