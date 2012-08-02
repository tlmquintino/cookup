# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package openjpeg;

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

	sub depends { return qw( cmake ); }

    sub name       { return "openjpeg"; }
    sub version    { return "1.5.0"; }
    sub url        { return "http://openjpeg.googlecode.com/files/openjpeg-1.5.0.tar.gz"; }

    sub md5   { return "e5d66193ddfa59a87da1eb08ea86293b"; }    
    sub sha1  { return "dce705ae45f137e4698a8cf39d1fbf22bc434fa8"; }    

    sub configure_command {
        my $self = shift;
        return "cmake -DCMAKE_INSTALL_PREFIX=" . $self->prefix;
    }

1;
