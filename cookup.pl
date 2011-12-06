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

my $cookbook_dir = cwd() . "/" . "cookbook";

push @INC, $cookbook_dir;

#==========================================================================
# main functions
#==========================================================================

sub parse_commandline() # Parse command line
{
    GetOptions ( \%options,
			'help', 
			'verbose', 
			'debug=i',
			'list',
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

sub found_recipe 
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

sub find_recipes
{
	my @cookbook = qw( cookbook );
	find( \&found_recipe, @cookbook );	
}

sub list_available_recipes
{
	foreach my $package ( keys %recipes ) 
	{
			my $recipe = $recipes{$package};
			my $package_name = $recipe->package_name;
			print "$package_name ";	
			if( exists $options{verbose} ) { print $recipe->url; }
			print "\n";	
	} 
}	

sub install_packages
{
	foreach my $package ( @{$options{install}} ) 
	{
		# check that recipe is in recipes list
		if( exists($recipes{$package}) )
		{
			my $recipe = $recipes{$package};
			my $package_name = $recipe->package_name;

			print "installing package [$package_name]\n";	

			  if( exists $options{verbose} ) { 
					$recipe->verbose( $options{verbose} ); 
				}

			  if( exists $options{debug} ) { 
					$recipe->debug( $options{debug} ); 
				}

			  $recipe->install_dir( cwd() );

		  	$recipe->cook();
		} 
		else 
		{ 
			die "no recipe for '$package' in our cookbook [$cookbook_dir]" ;
		}		
	}
}	

#==========================================================================
# Main execution
#==========================================================================

parse_commandline();

find_recipes();

if( exists $options{list} )
{
	list_available_recipes();
}

if( exists $options{install} )
{
	install_packages();
}
