# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package clang;

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

    sub depends { return qw( llvm ); }

    sub name       { return "clang"; }
    sub version    { return "3.1"; }
    sub url        { return "http://llvm.org/releases/3.1/clang-3.1.src.tar.gz"; }

    sub md5   { return "59bf2d3120a3805f27cafda3823caaf8"; }
    sub sha1  { return "19f33b187a50d22fda2a6f9ed989699a9a9efd62"; }

    sub package_dir { return "clang-3.1.src"; }

    sub build_dir {
        my $self = shift;
        my $pname = $self->package_name;
        return sprintf "%s/%s/build", $self->sandbox_dir, $self->package_dir;
    }

    sub configure_command {
        my $self = shift;
        return "cmake .. -DCMAKE_BUILD_TYPE=Release -DCLANG_PATH_TO_LLVM_BUILD=".$self->prefix." -DCMAKE_INSTALL_PREFIX:PATH=".$self->prefix;
    }

1;
