# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package llvm;

use strict;
use warnings;

use Recipe;

my %fields = (
    name     => "llvm",
    version  => "3.1",
    url      => "http://llvm.org/releases/3.1/llvm-3.1.src.tar.gz",
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

    sub md5   { return "16eaa7679f84113f65b12760fdfe4ee1"; }
    sub sha1  { return "234c96e73ef81aec9a54da92fc2a9024d653b059"; }

    sub package_dir { return "llvm-3.1.src"; }

    # returns the path to the build dir
    sub build_dir {
        my $self = shift;
        my $pname = $self->package_name;
        return sprintf "%s/%s/build", $self->sandbox_dir, $self->package_dir;
    }

    sub configure_command {
        my $self = shift;
        return "cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=".$self->prefix;
    }

1;
