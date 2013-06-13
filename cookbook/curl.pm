# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package curl;

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

    sub name       { return "curl"; }
    sub version    { return "7.30.0"; }
    sub url        { return "http://curl.haxx.se/download/curl-7.30.0.tar.gz"; }

    sub md5   { return "60bb6ff558415b73ba2f00163fd307c5"; }
    sub sha1  { return "792fcf6473c3bbeb344dea1d64c7ff65731c1be5"; }

	sub configure_command {
		my $self = shift;
		return "./configure --without-ssl --without-libidn --without-gnutls --disable-ipv6 --prefix=" . $self->prefix;
	}

1;
