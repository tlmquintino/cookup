# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package superlu;

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

    sub depends { return qw( cmake ); }

    sub name    { return "superlu"; }
    sub version { return "4.1"; }
    sub url     { return "http://coolfluidsrv.vki.ac.be/webfiles/coolfluid/packages/superlu-4.1.tar.gz"; }
    sub md5     { return "0766743afc4f65c372a42ed588e42e83"; }
    sub sha1    { return "4b4ae5f40bfd132d576f53a161733a4584e6a42f"; }

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

1;
