cmake_minimum_required(VERSION 2.8)

project( cookup )

add_custom_target( scripts ALL
  SOURCES
      cookbook/bison.pm
      cookbook/boost.pm
      cookbook/cmake.pm
      cookbook/curl.pm
      cookbook/flex.pm
      cookbook/gcc.pm
      cookbook/git.pm
      cookbook/gmp.pm
      cookbook/grib_api.pm
      cookbook/jasper.pm
      cookbook/libpng.pm
      cookbook/libtool.pm
      cookbook/m4.pm
      cookbook/mpc.pm
      cookbook/mpfr.pm
      cookbook/openjpeg.pm
      cookbook/openssl.pm
      cookbook/readline.pm
      cookbook/rsync.pm
      cookbook/wget.pm
      cookbook/zlib.pm
      cookup.pl
      Recipe.pm
      README
      LICENSE
)

set(CPACK_PACKAGE_VERSION   "0.1.4")
set(CPACK_SOURCE_IGNORE_FILES 
        /build/
        /\\\\.git/
        /\\\\.svn/
        CMakeLists.txt.user
        \\\\.swp$
)

include(CPack)

