# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package trilinos;

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

    sub depends { return qw( cmake openmpi parmetis hdf5 zlib ) };

    sub name       { return "trilinos"; }
    sub version    { return "11.2.3"; }
    sub url        { return "http://trilinos.sandia.gov/download/files/trilinos-11.2.3-Source.tar.gz"; }

    sub md5        { return "ebb073ddbc18a2ee18300b0aad89ddf8"; }
    sub sha1       { return "91ed5de34d9cf80cb03afe761e8e1bf07398221a"; }

    sub package_dir { return "trilinos-11.2.3-Source"; }
    
    sub build_dir {
      my $self = shift;
      return sprintf "%s/%s/build", $self->sandbox_dir, $self->package_dir;
    }

    sub configure_command {
      my $self = shift;

      my $path = $self->root_prefix();

      my $opts = "-DCMAKE_BUILD_TYPE:STRING=RELEASE \\
            -DCMAKE_PREFIX_PATH=$path \\
            -DCMAKE_VERBOSE_MAKEFILE=FALSE \\
            -DBUILD_SHARED_LIBS=ON \\
            -DTPL_ENABLE_MPI:BOOL=ON \\
            -DTPL_ENABLE_BLAS=ON \\
            -DTPL_ENABLE_LAPACK=ON \\
            -DTPL_ENABLE_Zlib:BOOL=ON \\
            -DTrilinos_VERBOSE_CONFIGURE=FALSE \\
            -DTrilinos_ENABLE_Fortran=OFF \\
            -DTrilinos_ENABLE_ALL_PACKAGES=ON \\
            -DTrilinos_ENABLE_ALL_OPTIONAL_PACKAGES=ON \\
            -DTrilinos_ENABLE_TESTS=OFF \\
            -DZoltan_ENABLE_ULLONG_IDS:BOOL=ON \\
            -DTrilinos_ENABLE_Teko:BOOL=ON \\
            -DTrilinos_ENABLE_ShyLU:BOOL=ON \\
            -DTPL_ENABLE_HDF5:BOOL=ON \\
            -DTPL_ENABLE_ParMETIS:BOOL=ON \\
            " ;


       # Some things don't compile or link. Here are the fixes.
       my $patches = "\\
         -DML_ENABLE_ParMETIS:BOOL=OFF \\
         ";

     $opts = $opts . "-DCMAKE_C_COMPILER=mpicc -DCMAKE_CXX_COMPILER=mpic++";
     return "cmake .. $opts $patches -DCMAKE_INSTALL_PREFIX:PATH=" . $self->prefix;
   }

#         -DCMAKE_SHARED_LINKER_FLAGS=-lhdf5 \\
   
# possible third-party dependencies :
# -----------------------------------
# TPL_ENABLE_ADIC                    
# TPL_ENABLE_ADOLC                   
# TPL_ENABLE_AMD                     
# TPL_ENABLE_ARPREC                  
# TPL_ENABLE_BLACS                   
# TPL_ENABLE_BLAS                  ON
# TPL_ENABLE_BinUtils                
# TPL_ENABLE_Boost                   
# TPL_ENABLE_BoostLib                
# TPL_ENABLE_CASK                    
# TPL_ENABLE_CSparse                 
# TPL_ENABLE_CUDA                    
# TPL_ENABLE_CUSPARSE                
# TPL_ENABLE_Clp                     
# TPL_ENABLE_CppUnit                 
# TPL_ENABLE_CrayPortals             
# TPL_ENABLE_Cusp                    
# TPL_ENABLE_Dakota                  
# TPL_ENABLE_ExodusII                
# TPL_ENABLE_ForUQTK                 
# TPL_ENABLE_GLPK                    
# TPL_ENABLE_Gemini                  
# TPL_ENABLE_HDF5                  ON
# TPL_ENABLE_HIPS                    
# TPL_ENABLE_HWLOC                   
# TPL_ENABLE_HYPRE                   
# TPL_ENABLE_InfiniBand              
# TPL_ENABLE_LAPACK                ON
# TPL_ENABLE_MA28                    
# TPL_ENABLE_MATLAB                  
# TPL_ENABLE_METIS                   
# TPL_ENABLE_MF                      
# TPL_ENABLE_MPI                   ON
# TPL_ENABLE_MUMPS                   
# TPL_ENABLE_Nemesis                 
# TPL_ENABLE_Netcdf                  
# TPL_ENABLE_OVIS                    
# TPL_ENABLE_OpenNURBS               
# TPL_ENABLE_Oski                    
# TPL_ENABLE_PARDISO_MKL             
# TPL_ENABLE_PETSC                   
# TPL_ENABLE_PaToH                   
# TPL_ENABLE_Pablo                   
# TPL_ENABLE_ParMETIS              ON
# TPL_ENABLE_Peano                   
# TPL_ENABLE_Pnetcdf                 
# TPL_ENABLE_Portals                 
# TPL_ENABLE_Pthread               ON
# TPL_ENABLE_QD                      
# TPL_ENABLE_QT                      
# TPL_ENABLE_SCALAPACK               
# TPL_ENABLE_SPARSKIT                
# TPL_ENABLE_Scotch                  
# TPL_ENABLE_SuperLU                 
# TPL_ENABLE_SuperLUDist             
# TPL_ENABLE_SuperLUMT               
# TPL_ENABLE_TAUCS                   
# TPL_ENABLE_TBB                     
# TPL_ENABLE_TVMET                   
# TPL_ENABLE_Thrust                  
# TPL_ENABLE_UMFPACK                 
# TPL_ENABLE_XDMF                    
# TPL_ENABLE_Zlib                  ON
# TPL_ENABLE_gtest                   
# TPL_ENABLE_y12m                    
# TPL_ENABLE_yaml-cpp                

1;
