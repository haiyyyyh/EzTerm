cmake_minimum_required(VERSION 3.15)
project(EzTerm VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -pedantic -Wshadow -fdiagnostics-color=always")
set(CMAKE_CXX_FLAGS_RELEASE "-O2")
set(CMAKE_CXX_FLAGS_DEBUG "-O0 -g")

include_directories(${PROJECT_SOURCE_DIR}/include)

add_library(ezterm SHARED src/ezterm.cpp)
set_target_properties(ezterm PROPERTIES
    POSITION_INDEPENDENT_CODE ON
    OUTPUT_NAME "ezterm"
    VERSION ${PROJECT_VERSION}
    SOVERSION 1)

add_library(ezterm_static STATIC src/ezterm.cpp)
set_target_properties(ezterm_static PROPERTIES
    OUTPUT_NAME "ezterm")

install(TARGETS ezterm ezterm_static
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
)
install(FILES include/ezterm.h DESTINATION include)

