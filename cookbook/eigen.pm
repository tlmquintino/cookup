# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package eigen;

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

    sub depends { return qw( cmake metis superlu ); }

	sub name       { return "eigen"; }
	sub version    { return "3.2.0"; }
	sub url        { my $self = shift; return "http://bitbucket.org/eigen/eigen/get/" . $self->version . ".tar.gz"; }     
	sub md5        { return "9559c34af203dde5f3f1d976d859c5b3"; }
	sub sha1       { return "7134378dd56608f67dd66ff6d5a2dfb077ef52a4"; }

	sub package_dir { return "eigen-eigen-ffa86ffb5570"; }

    sub build_dir {
        my $self = shift;
        return sprintf "%s/%s", $self->source_dir,"build";
    }

    sub configure_command {
      my $self = shift;
      return "cmake "
        ." -DCMAKE_PREFIX_PATH=".$self->root_prefix()
        ." -DCMAKE_INSTALL_PREFIX=".$self->prefix()
        ." ../";
    }

#    sub configure{ print "configure() not needed -- skipping\n"; } # not needed
#    sub build{ print "build() not needed -- skipping\n"; } # not needed
#    sub install_command {
#        my $self = shift;
#		my $dest = self->prefix . "/include";
#		mkpath $dest unless( -e $dest );
#		return "cp -r Eigen $dest";
#    }

1;
