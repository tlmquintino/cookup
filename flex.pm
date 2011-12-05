package flex;

use strict;
use warnings;
use Recipe;

my %fields = (
    name     => "flex",
    version  => "2.5.35",
		url      => "http://coolfluidsrv.vki.ac.be/webfiles/coolfluid/packages/flex-2.5.35.tar.gz"
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

		sub install
		{
        my $self = shift;
			 	printf "installing %s\n", $self->package();
			
				$self->download_src();
		}

1; 
