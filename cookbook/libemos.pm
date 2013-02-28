# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package libemos;

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

	# sub depends { return qw( jasper libpng ); }

    sub name       { return "libemos"; }
    sub version    { return "000392"; }
    sub url        { return "http://dl.dropbox.com/u/20038251/emos_000392.tar.gz"; }
    
    sub md5  { return "dbf8ca8662bacf2cc267818ba70a922e"; }         
    sub sha1 { return "711a9cb5825fa33487ecc889d39a469e7b84c98d"; } 

    sub configure_command {
    
        # TODO: modify this to edit the Makefile and produce an arch dependent build
        
# 1. run build_install and provide answers to questions
# 2. mkdir the install dir
# 3. run isntall to install it

        my $self = shift;
        my $fopts = "--disable-fortran";
        if ( exists $ENV{'FC'} or exists $ENV{'F77'} ) {
            $fopts = "" ; # don't say anything as it is the default
        }
		return "./configure --disable-jpeg $fopts CFLAGS='-fPIC' --prefix=" . $self->prefix;
	}

1;
