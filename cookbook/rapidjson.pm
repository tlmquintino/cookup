# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package rapidjson;

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

    sub name       { return "rapidjson"; }
    sub version    { return "0.11"; }
    sub url        { return "http://rapidjson.googlecode.com/files/rapidjson-0.11.zip"; }

    sub md5  { return "96a4b1b57ece8bc6a807ceb14ccaaf94"; }
    sub sha1 { return "3348f4ce925ee0e58da123abfafe09ba203d4fc3"; }

    sub package_dir { return "rapidjson"; }
            
    # header only so we copy the headers and that is it !

    sub configure {}

    sub build {}
    
    sub install {
        my $self = shift;
        die "no install dir prefix defined for ". $self->package_name unless($self->prefix);
        
        print ">>>> prefix [$self->prefix]\n";
        my $prefix = $self->prefix;
        print ">>>> prefix [$prefix]\n";
        my $inc = "$prefix/include";
        print "> installing " . $self->name ."\n" if($self->verbose);
        $self->chdir_to($self->source_dir);
        File::Path::mkpath $inc unless( -e $inc );
        my $output = $self->execute_command( "cp -r include/rapidjson $inc" );
        print "$output\n" if($self->debug);    
    }
1;
