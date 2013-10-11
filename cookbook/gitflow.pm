# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package gitflow;

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

    sub name       { return "gitflow"; }
    sub version    { return "15aab26"; }
    sub url        { return "https://dl.dropboxusercontent.com/u/20038251/gitflow-15aab26.tar.gz"; }
        
    sub md5  { return "8ce3e73628be7b54abfffe4602ebb432"; }
    sub sha1 { return "814f8f6138147742a135a8cc81f33d15bd43f715"; }

    sub configure_command {} # not needed

    sub build_command {} # not needed

    sub install {
        my $self = shift;
        return "make prefix=".$self->prefix()." install";        
    }
1;
