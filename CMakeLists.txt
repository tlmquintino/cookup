###############################################################################
#
# cookup project
#
# TODO:
#
#  * add install dir prefix to the PATH and LD_LIBRARY_PATH
#  * add support for dependencies checking - require another package
#  * add manifests?
#  * add variants
#
# MISSING RECIPES:
#
#  * blas / lapack
#  * atlas
#  * netcdf - http://www.unidata.ucar.edu/software/netcdf
#  * gmsh - http://geuz.org/gmsh
#  * superlu - http://www.cs.berkeley.edu/~demmel/SuperLU.html
#  * cppclean - http://code.google.com/p/cppclean
#  * googlemock - http://code.google.com/p/googlemock
#  * memcached - http://code.google.com/p/memcached
#  * valgrind - http://valgrind.org
#  * MMG3D - http://www.math.u-bordeaux1.fr/~cdobrzyn/logiciels/mmg3d.php
#  * Exodus II - http://sourceforge.net/projects/exodusii
#  * mpich2 - http://www.mcs.anl.gov/research/projects/mpich2
#  * qt
#  * paraview
#  * petsc
#  * gccgo
#  * codesearch https://code.google.com/p/codesearch/
#  * re2 - http://code.google.com/p/re2


###############################################################################

cmake_minimum_required( VERSION 2.8 )

project( cookup )

set(CPACK_PACKAGE_VERSION   "0.2.12")

add_custom_target( scripts ALL
  SOURCES
        cookbook/bison.pm
        cookbook/boost.pm
        cookbook/ccache.pm
        cookbook/cgal.pm
        cookbook/cgns.pm
        cookbook/clang.pm
        cookbook/cmake.pm
        cookbook/cmake_2_8_8.pm
        cookbook/curl.pm
        cookbook/distcc.pm
        cookbook/flex.pm
        cookbook/gcc.pm
        cookbook/git.pm
        cookbook/git_1_7_11_3.pm
        cookbook/glog.pm
        cookbook/gmp.pm
        cookbook/gperftools.pm
        cookbook/grib_api.pm
        cookbook/grib_api_1_9_9.pm
        cookbook/gtest.pm
        cookbook/hdf5.pm
        cookbook/jasper.pm
        cookbook/jemalloc.pm
        cookbook/libpng.pm
        cookbook/libtool.pm
        cookbook/libunwind.pm
        cookbook/libxml2.pm
        cookbook/libxslt.pm
        cookbook/llvm.pm
        cookbook/m4.pm
        cookbook/make.pm
        cookbook/metis.pm
        cookbook/mpc.pm
        cookbook/mpfr.pm
        cookbook/openjpeg.pm
        cookbook/openmpi.pm
        cookbook/openssl.pm
        cookbook/parmetis.pm
        cookbook/protobuf.pm
        cookbook/rapidjson.pm
        cookbook/readline.pm
        cookbook/rsync.pm
        cookbook/trilinos.pm
        cookbook/wget.pm
        cookbook/zlib.pm
        cookbook/zoltan.pm
        cookup.pl
        Recipe.pm
        README.md
        LICENSE
)

set(CPACK_SOURCE_IGNORE_FILES 
        /build/
        /\\\\.git/
        /\\\\.svn/
        CMakeLists.txt.user
        \\\\.swp$
)

message( STATUS "cookup ${CPACK_PACKAGE_VERSION}\n" )

include(CPack)

