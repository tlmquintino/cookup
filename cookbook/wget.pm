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
    sub version    { return "1.14"; }
    sub url        { return "http://ftp.gnu.org/gnu/wget/wget-1.14.tar.gz"; }

    sub md5  { return "12edc291dba8127f2e9696e69f36299e"; }
    sub sha1 { return "c487bce740b3a1847a35fb29b5c6700c46f639b8"; }

    sub configure_command {
        my $self = shift;
        return "./configure --without-ssl --prefix=" . $self->prefix;
    }

1;
