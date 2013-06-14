# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package llvm;

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

    sub name       { return "llvm"; }
    sub version    { return "3.3"; }
    sub url        { return "http://llvm.org/releases/3.3/llvm-3.3.src.tar.gz"; }
    
    sub md5   { return "40564e1dc390f9844f1711c08b08e391"; }
    sub sha1  { return "c6c22d5593419e3cb47cbcf16d967640e5cce133"; }

    sub package_dir { return "llvm-3.3.src"; }

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
