# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package libxslt;

use strict;
use warnings;

use Recipe;

my %fields = ();

our @ISA = ("Recipe");

    sub new {
        my $class = shift;
        my $self  = $class->SUPER::new();
        my($element);
        foreach $element (keys %fields) {
            $self->{_permitted}->{$element} = $fields{$element};
        }
        @{$self}{keys %fields} = values %fields;
        return $self;
    }
    
	sub depends { return qw( libxml2 ); }

    sub name       { return "libxslt"; }
    sub version    { return "1.1.28"; }
    sub url        { return "http://xmlsoft.org/sources/libxslt-1.1.28.tar.gz"; }
    
    sub configure_command {
        my $self = shift;
		return "./configure --with-libxml-prefix=" . $self->prefix . " --prefix=" . $self->prefix;
	}

    sub md5  { return "9667bf6f9310b957254fdcf6596600b7"; }
    sub sha1 { return "4df177de629b2653db322bfb891afa3c0d1fa221"; }

1;
