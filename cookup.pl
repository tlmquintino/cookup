#!/usr/bin/env perl

# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

use warnings;
use strict;

#==============================================================================
# Modules
#==============================================================================

use Cwd;
use Getopt::Long;
use File::Find;
use File::Basename;
use File::Path;
use Data::Dumper;

no warnings 'File::Find'; # dont issue warnings for 'weird' files

#==============================================================================
# main variables
#==============================================================================

my $default_cookbook = Cwd::abs_path(dirname(__FILE__) . "/" . "cookbook") ;
my $default_sandbox  = $ENV{HOME}."/"."tmp";
my $default_prefix   = "/usr/local";

my %options = ( prefix   => $default_prefix,
                sandbox  => $default_sandbox,
                cookbook => $default_cookbook, );
my %recipes = ();

my @package_list = ();

#==============================================================================
# main functions
#==============================================================================

sub parse_commandline() # Parse command line
{
    GetOptions ( \%options,
        'download',
        'unpack',
        'cook',
        'help',
        'verbose',
        'debug',
        'nodeps',
        'list',
        'dry-run',
        'prefix=s',
        'cookbook=s',
        'sandbox=s',
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
        --nodeps            don't check dependencies
        --list              list all the recipes in the cookbook
        --dry-run           don't actually do it, just list the packages that would be cooked
        --prefix            install dir prefix [$default_prefix]
        --cookbook          use directory as cookbook [$default_cookbook]
        --sandbox           use directory as sandbox for building [$default_sandbox]
        --packages=list     comma separated list of packages to apply actions on

EXAMPLE:
  cookup.pl --cook --packages=wget
ZZZ
        exit(0);
    }

      if( exists $options{packages} ) # process comma separated list
      {
          my @packages = split(',',join(",",@{$options{packages}}));
          # print "@packages\n";
          $options{packages} = \@packages;
      }
      
      my $prefix   = $options{'prefix'};
      my $sandbox  = $options{'sandbox'};
      my $cookbook = $options{'cookbook'};

      # create prefix dir if does not exist
      mkpath $prefix unless ( -w $prefix );

      # create sandbox dir if does not exist
      mkpath $sandbox unless ( -w $sandbox );

      # resolve relative paths to absolute paths
      die "cannot write to directory '".$prefix."'\n" unless ( -w $prefix and -d $prefix );
      $prefix   = Cwd::abs_path( $prefix  );
      die "cannot write to directory '".$sandbox."'\n" unless ( -w $sandbox and -d $sandbox );
      $sandbox  = Cwd::abs_path( $sandbox );
      die "cannot read from directory '".$cookbook."'\n" unless ( -d $cookbook and -r $cookbook );
      $cookbook = Cwd::abs_path( $cookbook);
}

#==============================================================================

sub prepare()
{
    # prepend paths with installation prefix
    # but avoid warnings of uninitialized variables

    my $path    = $ENV{PATH}; $path = "" unless ($path);
    my $libpath = $ENV{LIBPATH}; $libpath = "" unless ($libpath);
    my $ldpath  = $ENV{LD_LIBRARY_PATH}; $ldpath = "" unless ($ldpath);
    my $dypath  = $ENV{DYLD_LIBRARY_PATH}; $dypath = "" unless ($dypath);
    
    my $prefix   = $options{'prefix'};

    $ENV{PATH}              = $prefix."/bin:".$path;
    $ENV{LIBPATH}           = $prefix."/lib:".$libpath;
    $ENV{LD_LIBRARY_PATH}   = $prefix."/lib:".$ldpath;
    $ENV{DYLD_LIBRARY_PATH} = $prefix."/lib:".$dypath;
}

#==============================================================================

sub found_recipe
{
    my ($fname,$path,$suffix) = fileparse($_, qr/\.[^.]*/);
    #print "path [$path] name [$fname] suffix [$suffix]\n";
    if( $suffix eq ".pm")
    {
        require "$fname$suffix";

        my $recipe  = $fname->new();
        my $name    = $recipe->name();
        my $version = $recipe->version();
        my $namevrs = "$name-$version";

        $recipes{$name} = $recipe if( $fname eq $name ); # add if is the master version
 
#     FTM: turned off version       
#     $recipes{$namevrs} = $recipe;
        
        print "> found recipe for " . $recipe->name . "-" . $version . "\n" if( $options{debug} );
    }
}

#==============================================================================

sub find_recipes
{
  my @cookbook;
  my $cookbook_path = Cwd::abs_path($options{cookbook});
  push (@cookbook, $cookbook_path);
  if( $options{verbose} ) { print "searching for recipes in $cookbook_path\n" }
  find( \&found_recipe, @cookbook );
}

#==============================================================================

sub list_available_recipes
{
  foreach my $package ( sort keys %recipes )
  {
      my $recipe = $recipes{$package};
      my $package_name = $recipe->package_name;
      if( exists $options{verbose} ) 
	  {
		print "$package_name\n";
	  }
      else
	  {	
		print "$package_name ( ".$recipe->url()." )\n";
      } 
  }
}

#==============================================================================

sub process_one_package
{
    my $package = shift;

    my $recipe = $recipes{$package};
    my $package_name = $recipe->package_name;

    print "package [$package_name]\n";

    if( !exists $options{'dry-run'} ) 
    {
        $recipe->verbose( $options{verbose} ) unless ( !exists $options{verbose} );
        $recipe->debug( $options{debug} ) unless ( !exists $options{debug} );
    
        $recipe->prefix ( $options{prefix } );
        $recipe->sandbox( $options{sandbox} );
    
        $recipe->download_src() unless ( !exists $options{download} && !exists $options{unpack} );
        $recipe->unpack_src()   unless ( !exists $options{unpack} );
    
        $recipe->cook() unless ( !exists $options{cook} );
    }
}

#==============================================================================

sub transverse_dependency_tree
{
    my (@list) = @_;

#    print Dumper( @list ) if( $options{debug} );

    my $cookbook = $options{cookbook};

    foreach my $package ( @list )
  {
        if( exists( $recipes{$package} ) )
        {
            my $recipe = $recipes{$package};
            my $package_name = $recipe->package_name;
            my @depends = $recipe->depends();
            
            transverse_dependency_tree( @depends ) if( scalar @depends != 0 );

            if ( !( grep( /^$package$/, @package_list ) ) ) # dont add if already in list
            {
                push @package_list, $package;
            }
        }
        else
        {
            die "no recipe for '$package' in our cookbook [$cookbook]" ;
        }
    }
}

#==============================================================================

sub process_packages_list
{
    my $cookbook = $options{cookbook};
    
    # verify all packages exist
  foreach my $package ( @{$options{packages}} )
  {
    if( ! exists($recipes{$package}) )
    {
      die "no recipe for '$package' in our cookbook [$cookbook]" ;
    }
  }    

  if( ! exists($options{nodeps}) )
  {
    transverse_dependency_tree( @{$options{packages}} );
  }
  else # just copy whatever was passed to the package_list
  {
    @package_list = @{$options{packages}};
  }

  # verify all packages exist
  foreach my $package ( @package_list )
  {
    process_one_package( $package );
  }
}

#==============================================================================
# Main execution
#==============================================================================

parse_commandline();

prepare();

push @INC, Cwd::abs_path(dirname(__FILE__)); # Recipe class is in same dir as the script
push @INC, $options{cookbook};

find_recipes();

list_available_recipes() unless (!exists $options{list});

process_packages_list() unless (!exists $options{packages});
