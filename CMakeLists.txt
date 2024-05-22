cmake_minimum_required(VERSION 3.10)
project(appshift)

find_package(PkgConfig REQUIRED)
pkg_check_modules(DEPS REQUIRED gtk+-3.0 granite)

include_directories(${DEPS_INCLUDE_DIRS})
link_directories(${DEPS_LIBRARY_DIRS})

set(SOURCES
    src/main.vala
    src/application.vala
    src/window.vala
    src/utils.vala
)

add_definitions(${DEPS_CFLAGS_OTHER})

add_executable(appshift ${SOURCES})

target_link_libraries(appshift ${DEPS_LIBRARIES})

# GResources
glib_compile_resources(
    src/org.example.AppShift.gresource.xml
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/data
    C_SOURCE
    gresources.c
)
add_library(gresources OBJECT gresources.c)
add_dependencies(appshift gresources)
target_link_libraries(appshift gresources)

