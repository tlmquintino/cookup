# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package readline;

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

    sub name       { return "readline"; }
    sub version    { return "6.2"; }
    sub url        { return "http://ftp.gnu.org/gnu/readline/readline-6.2.tar.gz"; }

    sub md5  { return "67948acb2ca081f23359d0256e9a271c"; }
    sub sha1 { return "a9761cd9c3da485eb354175fcc2fe35856bc43ac"; }
1;
