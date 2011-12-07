package curl;

use strict;
use warnings;

use Recipe;

my %fields = (
    name     => "curl",
    version  => "7.21.4",
		url      => "http://ftp.gnu.org/gnu/curl/curl-7.21.4.tar.gz",
#		md5      => "1df489976a118b9cbe1b03502adbfc27",
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
			return "./configure --without-ssl --without-libidn --without-gnutls --disable-ipv6 --prefix=" . $self->prefix;
		}


1; 
