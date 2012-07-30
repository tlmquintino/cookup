cmake_minimum_required(VERSION 2.8)

project( cookup )

add_custom_target( scripts ALL
  SOURCES
      cookbook/bison.pm
      cookbook/boost.pm
      cookbook/ccache.pm
      cookbook/cmake.pm
      cookbook/curl.pm
      cookbook/distcc.pm
      cookbook/flex.pm
      cookbook/jemalloc.pm
      cookbook/gcc.pm
      cookbook/git.pm
      cookbook/gmp.pm
      cookbook/gperftools.pm
      cookbook/gtest.pm
      cookbook/glog.pm
      cookbook/jasper.pm
      cookbook/libpng.pm
      cookbook/libtool.pm
      cookbook/libunwind.pm
      cookbook/libxml2.pm
      cookbook/libxslt.pm
      cookbook/m4.pm
      cookbook/make.pm
      cookbook/mpc.pm
      cookbook/mpfr.pm
      cookbook/openjpeg.pm
      cookbook/openmpi.pm
      cookbook/openssl.pm
      cookbook/parmetis.pm
      cookbook/protobuf.pm
      cookbook/readline.pm
      cookbook/rapidjson.pm
      cookbook/rsync.pm
#      cookbook/trilinos.pm
      cookbook/wget.pm
      cookbook/zlib.pm
      cookbook/zoltan.pm
      cookup.pl
      Recipe.pm
      README
      LICENSE
)

set(CPACK_PACKAGE_VERSION   "0.2.3")
set(CPACK_SOURCE_IGNORE_FILES 
        /build/
        /\\\\.git/
        /\\\\.svn/
        CMakeLists.txt.user
        \\\\.swp$
)

include(CPack)

