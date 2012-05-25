cmake_minimum_required(VERSION 2.8)
project(qtmc)

find_package(Qt4 COMPONENTS QtCore QtDeclarative REQUIRED)
include(${QT_USE_FILE})

set(qtmc_HEADERS qtmc.h)
set(qtmc_SOURCES qtmc.cpp main.cpp)
set(qtmc_TRANSLATIONS ../translations/qtmc_nl.ts)

qt4_wrap_cpp(qtmc_MOC ${qtmc_HEADERS})
qt4_add_translation(qtmc_QM ${qtmc_TRANSLATIONS})

include_directories(${CMAKE_CURRENT_BINARY_DIR})

add_executable(qtmc
    ${qtmc_SOURCES}
    ${qtmc_MOC}
    ${qtmc_QM}
)

target_link_libraries(qtmc ${QT_LIBRARIES} mediadb)

# Copy share directory to bin-dir
file(COPY ../lib DESTINATION ${CMAKE_CURRENT_BINARY_DIR}/..)

# Install binary
install(TARGETS qtmc
        BUNDLE  DESTINATION ${CMAKE_INSTALL_PREFIX}/bin
        RUNTIME DESTINATION ${CMAKE_INSTALL_PREFIX}/bin)

# Install share directory
install(DIRECTORY ../lib DESTINATION ${CMAKE_INSTALL_PREFIX})

# Install translations
install(FILES ${qtmc_QM} DESTINATION ${CMAKE_INSTALL_PREFIX}/lib/qtmc/translations)
