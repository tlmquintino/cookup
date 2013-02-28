# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package rsync;

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

    sub name       { return "rsync"; }
    sub version    { return "3.0.9"; }
    sub url        { return "http://rsync.samba.org/ftp/rsync/src/rsync-3.0.9.tar.gz"; }

    sub md5  { return "5ee72266fe2c1822333c407e1761b92b"; }
    sub sha1 { return "c64c8341984aea647506eb504496999fd968ddfc"; }

1;
