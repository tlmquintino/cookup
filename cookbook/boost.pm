# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.
# In applying this licence, ECMWF does not waive the privileges and immunities
# granted to it by virtue of its status as an intergovernmental organisation nor
# does it submit to any jurisdiction.

package boost;

use strict;
use warnings;

use Recipe;

my %fields = (
    name     => "boost",
    version  => "1.48.0",
		url      => "http://download.sourceforge.net/boost/boost_1_48_0.tar.gz",
		md5      => "313a11e97eb56eb7efd18325354631be",
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

		sub package_dir { return "boost_1_48_0"; }

		# string for the configure command
		sub configure_command {
			my $self = shift;
			return "./bootstrap.sh --prefix=" . $self->prefix;
		}

		# string for the build command
		# in this case it also installs
		sub build_command {
			my $self = shift;
			return "./b2 --prefix=".$self->prefix." variant=release link=shared threading=multi install";
		}

		# no install, done together with the build
		sub install {}

1;
