# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package wget;

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

    sub name       { return "wget"; }
    sub version    { return "1.13.4"; }
    sub url        { return "http://ftp.gnu.org/gnu/wget/wget-1.13.4.tar.gz"; }

    sub md5  { return "1df489976a118b9cbe1b03502adbfc27"; }
    sub sha1 { return "e25e1b487026ddd9026ca7d26af21f044c884d28"; }

    sub configure_command {
        my $self = shift;
        return "./configure --without-ssl --prefix=" . $self->prefix;
    }

1;
