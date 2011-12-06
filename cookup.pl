#!/usr/bin/env perl

use warnings;
use strict;

# use lib 'cookbook';

#==========================================================================
# Modules
#==========================================================================
use Cwd;
use Getopt::Long;
use File::Find;
use File::Basename;
use Module::Load;
use Data::Dumper;

no warnings 'File::Find'; # dont issue warnings for 'weird' files

use Recipe;

#==========================================================================
# main variables
#==========================================================================

my %options = ();
my %recipes = ();

#==========================================================================
# main functions
#==========================================================================

sub parse_commandline() # Parse command line
{
    GetOptions ( \%options,
			'help', 
			'verbose', 
			'debug',
			'install=s@',
		); 

    # show help if required
    if( exists $options{help} )
    {
      print <<ZZZ;
cookup.pl : easy build and install for UNIX platforms

usage: cookup.pl <action> [options]

actions:
        --help             shows this help
        --verbose          print every comand before executing
        --debug level      sets the debug level
				--install=list     comma separated list of recipes to cook
ZZZ
    exit(0);
    }

		if( exists $options{install} )
		{			
			my @install = split(',',join(",",@{$options{install}}));
			# print "@install\n";
			$options{install} = \@install;
		}
		
}

sub list_recipes 
{		
		my ($name,$path,$suffix) = fileparse($_, qr/\.[^.]*/);
		#	print "path [$path] name [$name] suffix [$suffix]\n";
		if( $suffix eq ".pm") 
		{
	  		load $name;
				my $recipe  = $name->new();
				my $version = $recipe->version();
				$recipes{$name} = $recipe;
#				print "$name $version\n";
		}
}

#==========================================================================
# Main execution
#==========================================================================

my $cookbook_dir = cwd() . "/" . "cookbook";

push @INC, $cookbook_dir;

parse_commandline();

my @cookbook = qw( cookbook );

find( \&list_recipes, @cookbook);

# print "@recipes\n";

		if( exists $options{install} )
		{
			foreach my $package ( @{$options{install}} ) 
			{
												
				# check that recipe is in recipes list
				if( exists($recipes{$package}) )
				{
					my $recipe = $recipes{$package};
					my $package_name = $recipe->package_name;
					print "installing package [$package_name]\n";	
	 			  $recipe->debug(1);
	 			  $recipe->install_dir( cwd() );
				  $recipe->cook();
				} 
				else 
				{ 
					die "no recipe for '$package' in our cookbook [$cookbook_dir]" ;
				}		
			}
		}

