# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package wget;

use strict;
use warnings;

use Recipe;

my %fields = (
    name     => "wget",
    version  => "1.13.4",
	url      => "http://ftp.gnu.org/gnu/wget/wget-1.13.4.tar.gz",
	md5      => "1df489976a118b9cbe1b03502adbfc27",
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

		# string for the configure command
		sub configure_command {
			my $self = shift;
			return "./configure --without-ssl --prefix=" . $self->prefix;
		}


1;
