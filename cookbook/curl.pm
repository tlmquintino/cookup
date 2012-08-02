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
    sub version    { return "7.27.0"; }
    sub url        { return "http://curl.haxx.se/download/curl-7.27.0.tar.gz"; }

    sub md5   { return "f0e48fdb635b5939e02a9291b89e5336"; }    
    sub sha1  { return "93ec1e206350632f550cc2ba3327e2a588bf0617"; }    

	sub configure_command {
		my $self = shift;
		return "./configure --without-ssl --without-libidn --without-gnutls --disable-ipv6 --prefix=" . $self->prefix;
	}

1;
