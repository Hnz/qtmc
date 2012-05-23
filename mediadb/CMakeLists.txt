cmake_minimum_required(VERSION 2.8)
project(mediadb)
find_package(Qt4 COMPONENTS QtCore QtSql REQUIRED)
include(${QT_USE_FILE})

# Define the MOC source files used by mediadb
set(MEDIADB_HEADERS
    mediadb.h
)

# Define the C++ source files used by mediadb
set(MEDIADB_HEADERS_Srcs
    mediadb.cpp
)

qt4_wrap_cpp(MEDIADB_HEADERS_Srcs ${MEDIADB_HEADERS})
add_library (mediadb ${MEDIADB_HEADERS_Srcs})
