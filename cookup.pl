#!/usr/bin/env perl

use warnings;
use strict;

use lib 'cookbook';

#==========================================================================
# Modules
#==========================================================================
use Cwd;
use Getopt::Long;
use File::Find;
use File::Basename;
use Module::Load;

no warnings 'File::Find';

#==========================================================================
# Global Variables
#==========================================================================

my $opt_help          = 0;
my $opt_verbose       = 0;

my @recipes;

#==========================================================================
# Command Line
#==========================================================================

sub parse_commandline() # Parse command line
{
    $opt_help=1 unless GetOptions (
        'help'                  => \$opt_help,
        'verbose'               => \$opt_verbose,
    );

    # show help if required
    if ($opt_help != 0)
    {
      print <<ZZZ;
cookup.pl : easy build and install for UNIX platforms

usage: cookup.pl [options]

options:
        --help             Show this help.
        --verbose          Print every comand before executing.
ZZZ
    exit(0);
    }
}


sub list_recipes 
{		
		my ($name,$path,$suffix) = fileparse($_, qr/\.[^.]*/);
		#	print "path [$path] name [$name] suffix [$suffix]\n";
		if( $suffix eq ".pm") {	push(@recipes, $name); }
}

#==========================================================================
# Main execution
#==========================================================================

parse_commandline();

my @cookbook = qw( cookbook );

find( \&list_recipes, @cookbook);

print "@recipes\n";

foreach my $recipe ( @recipes ) {
	
	load $recipe;
	
	my $food = $recipe->new();
	$food->debug(1);
	$food->install_dir( cwd() );
	$food->cook();

}

