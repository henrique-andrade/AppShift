cmake_minimum_required(VERSION 3.10)
project(appshift C)

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

# GResources
set(GRESOURCE_XML ${CMAKE_SOURCE_DIR}/data/org.example.AppShift.gresource.xml)
set(GRESOURCE_C ${CMAKE_BINARY_DIR}/gresources.c)

add_custom_command(
    OUTPUT ${GRESOURCE_C}
    COMMAND glib-compile-resources
    --generate-source
    --target=${GRESOURCE_C}
    ${GRESOURCE_XML}
    DEPENDS ${GRESOURCE_XML}
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/data
)

add_executable(appshift ${SOURCES} ${GRESOURCE_C})

target_link_libraries(appshift ${DEPS_LIBRARIES})

