# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package rsync;

use strict;
use warnings;

use Recipe;

my %fields = (
    name     => "rsync",
    version  => "3.0.9",
		url      => "http://rsync.samba.org/ftp/rsync/src/rsync-3.0.9.tar.gz",
		md5      => "5ee72266fe2c1822333c407e1761b92b",
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

1;
