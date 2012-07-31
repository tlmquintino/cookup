# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package trilinos;

use strict;
use warnings;

use Recipe;

my %fields = (
    name     => "trilinos",
    version  => "10.10.2",
    url      => "http://trilinos.sandia.gov/download/files/trilinos-10.10.2-Source.tar.gz",
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
    
		sub package_dir { return "trilinos-10.10.2-Source"; }
        
        sub md5 { return "0bb1116a438ac3b7a070ded153ee229f"; }
        
        # gets the path to the build dir
        sub build_dir {
                my $self = shift;
				my $pname = $self->package_name;
				return sprintf "%s/%s/build", $self->sandbox_dir, $self->package_dir;
        }
        
		# string for the configure command
		sub configure_command {
			my $self = shift;
            
my $opts = "-DCMAKE_BUILD_TYPE:STRING=RELEASE \\
            -DTrilinos_ENABLE_DEFAULT_PACKAGES=OFF \\
            -DTrilinos_ENABLE_ALL_OPTIONAL_PACKAGES=ON \\
            -DTrilinos_ENABLE_TESTS=OFF \\
            -DTrilinos_ENABLE_Amesos=ON \\
            -DTrilinos_ENABLE_AztecOO=ON \\
            -DTrilinos_ENABLE_Belos=ON \\
            -DTrilinos_ENABLE_Didasko=OFF \\
            -DDidasko_ENABLE_TESTS=OFF \\
            -DDidasko_ENABLE_EXAMPLES=OFF \\
            -DTrilinos_ENABLE_Epetra=ON \\
            -DTrilinos_ENABLE_EpetraExt=ON \\
            -DTrilinos_ENABLE_Tpetra=ON \\
            -DTrilinos_ENABLE_Teko=ON \\
            -DTrilinos_ENABLE_TpetraExt=ON \\
            -DTrilinos_ENABLE_Ifpack=ON \\
            -DTrilinos_ENABLE_Meros=ON \\
            -DTrilinos_ENABLE_ML=ON \\
            -DTrilinos_ENABLE_RTOp=ON \\
            -DTrilinos_ENABLE_Teuchos=ON \\
            -DTrilinos_ENABLE_Thyra=ON \\
            -DTrilinos_ENABLE_ThyraCore=ON \\
            -DTrilinos_ENABLE_Triutils=ON \\
            -DTrilinos_ENABLE_Stratimikos=ON \\
            -DTrilinos_ENABLE_Zoltan=ON \\
            -DZoltan_ENABLE_EXAMPLES=ON \\
            -DZoltan_ENABLE_TESTS=ON \\
            -DZoltan_ENABLE_ULLONG_IDS=ON \\
            -DTPL_ENABLE_BLAS=ON \\
            -DTPL_ENABLE_LAPACK=ON \\
            -DCMAKE_VERBOSE_MAKEFILE=FALSE \\
            -DBUILD_SHARED_LIBS=ON \\
            -DTrilinos_VERBOSE_CONFIGURE=FALSE ";

     $opts = $opts . " -DTrilinos_ENABLE_Fortran=OFF -DTPL_ENABLE_MPI=ON -DCMAKE_C_COMPILER=mpicc -DCMAKE_CXX_COMPILER=mpic++";
      
      #               -D MPI_BASE_DIR_PATH:PATH=$opt_mpi_dir 
      #               -D CMAKE_Fortran_COMPILER:FILEPATH=$opt_mpi_dir/bin/mpif77 
      
      #                     -D Zoltan_ENABLE_ParMETIS=ON \\
      #                     -D ParMETIS_INCLUDE_DIRS:FILEPATH=\"$opt_install_mpi_dir/include\" \\
      #                     -D ParMETIS_LIBRARY_DIRS:FILEPATH=\"$opt_install_mpi_dir/lib\"";

      # -D Trilinos_ENABLE_Fortran=OFF
      # -D CMAKE_Fortran_COMPILER:FILEPATH
      
			return "cmake .. $opts -DCMAKE_INSTALL_PREFIX:PATH=" . $self->prefix;
		}

1;
