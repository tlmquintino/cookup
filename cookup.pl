#!/usr/bin/env perl

# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

use warnings;
use strict;

# TODO:
#  * add install dir prefix to the PATH and LD_LIBRARY_PATH
#  * add support for dependencies checking - require another package
#  * add manifests?
#  * add variants
#
# MISSING RECIPES:
#  * parmetis
#  * hdf5
#  * trilinos
#  * cgns
#  * cgal
#  * superlu

#==========================================================================
# Modules
#==========================================================================

use Cwd;
use Getopt::Long;
use File::Find;
use File::Basename;
use Data::Dumper;

no warnings 'File::Find'; # dont issue warnings for 'weird' files

#==========================================================================
# main variables
#==========================================================================

my $default_cookbook = Cwd::abs_path(dirname(__FILE__) . "/" . "cookbook") ;
my $default_sandbox  = $ENV{HOME}."/"."tmp";
my $default_prefix   = "/usr/local";

my %options = ( prefix   => $default_prefix,
				sandbox  => $default_sandbox,
				cookbook => $default_cookbook, );
my %recipes = ();

#==========================================================================
# main functions
#==========================================================================

sub parse_commandline() # Parse command line
{
    GetOptions ( \%options,
			'prefix=s',
			'sandbox=s',
			'cookbook=s',
			'prefix=s',
			'help',
			'verbose',
			'debug',
			'list',
			'download',
			'unpack',
			'cook',
			'packages=s@',
		);

    # show help if required
    if( exists $options{help} )
    {
      print <<ZZZ;
cookup.pl : easy build and install for UNIX platforms

usage: cookup.pl <action> [options]

actions:
				--download          download the package sources
				--unpack            downloads and unpacks the package sources
				--cook              cookup the packages following the recipe

options:
        --help              shows this help
        --verbose           print every comand before executing
        --debug level       sets the debug level
        --list              list all the recipes in the cookbook
        --prefix            install dir prefix (same as --install-dir) [$default_prefix]
        --cookbook          use directory as cookbook [$default_cookbook]
        --sandbox           use directory as sandbox for building [$default_sandbox]
        --packages=list     comma separated list of packages to apply actions on

ZZZ
    exit(0);
    }

      if( exists $options{packages} ) # process comma separated list
      {
          my @packages = split(',',join(",",@{$options{packages}}));
          # print "@packages\n";
          $options{packages} = \@packages;
      }

	# resolve relative paths to absolute paths
       die "bad path '".$options{prefix}."'\n" unless ( defined (Cwd::abs_path( $options{prefix} ) ) );
       $options{prefix}   = Cwd::abs_path( $options{prefix}  );
       die "bad path '".$options{prefix}."'\n" unless ( defined (Cwd::abs_path( $options{sandbox} ) ) );
       $options{sandbox}  = Cwd::abs_path( $options{sandbox} );
       die "bad path '".$options{prefix}."'\n" unless ( defined (Cwd::abs_path( $options{cookbook} ) ) );
       $options{cookbook} = Cwd::abs_path( $options{cookbook});
}

sub prepare()
{
        # prepend paths with installation prefix
        # but avoid warnings of uninitialized variables
        my $path = $ENV{PATH}; $path = "" unless ($path);
        my $ldpath = $ENV{LD_LIBRARY_PATH}; $ldpath = "" unless ($ldpath);
        my $dypath = $ENV{DYLD_LIBRARY_PATH}; $dypath = "" unless ($dypath);

	  $ENV{PATH} = $options{prefix}."/bin:".$path;
	  $ENV{LD_LIBRARY_PATH}   = $options{prefix}."/lib:".$ldpath;
	  $ENV{DYLD_LIBRARY_PATH} = $options{prefix}."/lib:".$dypath;
}

sub found_recipe
{
		my ($name,$path,$suffix) = fileparse($_, qr/\.[^.]*/);
		#	print "path [$path] name [$name] suffix [$suffix]\n";
		if( $suffix eq ".pm")
		{
                require "$name$suffix";
				my $recipe  = $name->new();
				my $version = $recipe->version();
				$recipes{$name} = $recipe;
				if( $options{debug} ) { print "> found recipe for " . $recipe->name . "-" . $version . "\n" }
		}
}

sub find_recipes
{
	my @cookbook;
	my $cookbook_path = Cwd::abs_path($options{cookbook});
	push (@cookbook, $cookbook_path);
	if( $options{verbose} ) { print "searching for recipes in $cookbook_path\n" }
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

sub process_packages
{
	foreach my $package ( @{$options{packages}} )
	{
		# check that recipe is in recipes list
		if( exists($recipes{$package}) )
		{
			my $recipe = $recipes{$package};
			my $package_name = $recipe->package_name;

			print "package [$package_name]\n";

				$recipe->verbose( $options{verbose} ) unless ( !exists $options{verbose} );
				$recipe->debug( $options{debug} ) unless ( !exists $options{debug} );

			  $recipe->prefix ( $options{prefix } );
			  $recipe->sandbox( $options{sandbox} );

				$recipe->download_src() unless ( !exists $options{download} && !exists $options{unpack} );

				$recipe->unpack_src()   unless ( !exists $options{unpack} );

				$recipe->cook() unless ( !exists $options{cook} );

		}
		else
		{
			my $cookbook = $options{cookbook};
			die "no recipe for '$package' in our cookbook [$cookbook]" ;
		}
	}
}

#==========================================================================
# Main execution
#==========================================================================

parse_commandline();

prepare();

push @INC, Cwd::abs_path(dirname(__FILE__)); # Recipe class is in same dir as the script
push @INC, $options{cookbook};

find_recipes();

list_available_recipes() unless (!exists $options{list});

process_packages() unless (!exists $options{packages});
