cmake_minimum_required(VERSION 2.8)

project(qtmc)

find_package(Qt4 COMPONENTS QtCore QtDeclarative REQUIRED)
include(${QT_USE_FILE})

set(qtmc_HEADERS qtmc.h)
set(qtmc_SOURCES qtmc.cpp main.cpp)
set(qtmc_RESOURCES qtmc.qrc)

qt4_wrap_cpp(qtmc_MOC ${qtmc_HEADERS})
qt4_add_resources(qtmc_RESOURCES_CPP ${qtmc_RESOURCES})

include_directories(${CMAKE_CURRENT_BINARY_DIR})

add_executable(qtmc
    ${qtmc_SOURCES}
    ${qtmc_MOC}
    ${qtmc_RESOURCES_CPP}
)

target_link_libraries(qtmc ${QT_LIBRARIES} mediadb)

# Install binary
install(TARGETS qtmc
        BUNDLE  DESTINATION ${CMAKE_INSTALL_PREFIX}/bin
        RUNTIME DESTINATION ${CMAKE_INSTALL_PREFIX}/bin)
