
# Project Info
project("QtMC")
set(CPACK_PACKAGE_NAME "qtmc")
set(CPACK_PACKAGE_VERSION "0.0.2")
set(CPACK_PACKAGE_DESCRIPTION "Media Center based on Qt")


# Configure cmake
cmake_minimum_required(VERSION 2.8)
set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake ${CMAKE_MODULE_PATH})
set(CPACK_PACKAGE_EXECUTABLES "qtmc")


# Configuring build type
IF(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Debug" CACHE STRING
        "Choose the type of build, options are: None Debug Release RelWithDebInfo MinSizeRel."
        FORCE)
    message("Setting build type to '${CMAKE_BUILD_TYPE}'")
else(NOT CMAKE_BUILD_TYPE)
    message("Build type set to '${CMAKE_BUILD_TYPE}'")
endif(NOT CMAKE_BUILD_TYPE)


# For projects using Git, use git version patch
set(QTMC_REVISION "")
if(NOT "${CMAKE_BUILD_TYPE}" STREQUAL "Release")
    # Find Git Version Patch   
    find_program(GIT git)
    if(GIT)
        execute_process(
            WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
            COMMAND ${GIT} rev-parse --short HEAD 
            OUTPUT_VARIABLE GIT_OUT OUTPUT_STRIP_TRAILING_WHITESPACE
        )
        set(QTMC_REVISION "${GIT_OUT}")
    endif(GIT)
endif(NOT "${CMAKE_BUILD_TYPE}" STREQUAL "Release")


MESSAGE(STATUS "-= Building QtMC =-")
MESSAGE(STATUS "Version: ${CPACK_PACKAGE_VERSION}")
MESSAGE(STATUS "Revision: ${QTMC_REVISION}")


# Set UNIX-specifics
if (UNIX)
    set(WITH_PROFILING FALSE CACHE BOOL "Build with profiling support" )
    set(CMAKE_INSTALL_PREFIX /usr)
endif(UNIX)


# Generate qtmc_global.h
configure_file(qtmc_global.h.in ${CMAKE_SOURCE_DIR}/qtmc_global.h)


# Copy stuff to doc subdirectory
install(FILES README.md LICENSE DESTINATION ${CMAKE_INSTALL_PREFIX}/share/doc/qtmc)


# Copy .desktop file
install(FILES qtmc.desktop DESTINATION ${CMAKE_INSTALL_PREFIX}/share/applications)


# Copy the QTMC pixmap
install(FILES qtmc.png DESTINATION ${CMAKE_INSTALL_PREFIX}/share/pixmaps)


# NSIS Windows installer
if(WIN32 AND NOT UNIX)
    set(CPACK_PACKAGE_ICON "${CMAKE_SOURCE_DIR}/qtmc.png")
endif(WIN32 AND NOT UNIX)


# Mac App Bundle
if(APPLE)
    set(CPACK_GENERATOR "DragNDrop")
    set(CPACK_COMPONENT_LIBRARIES_HIDDEN TRUE)
endif(APPLE)


# Enable creation of source archive using "make package_source"
# From http://agateau.com/2009/08/09/cmake-and-make-dist/
set(CPACK_SOURCE_GENERATOR "TGZ")
set(CPACK_SOURCE_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}-${CPACK_PACKAGE_VERSION}")
set(CPACK_SOURCE_IGNORE_FILES "/build/;/.git/;~$;${CPACK_SOURCE_IGNORE_FILES}")

include(CPack)

# Add sub dirs
add_subdirectory(mediadb)
add_subdirectory(qtmc)
