cmake_minimum_required(VERSION 3.15)
project(FlutterEmbedderGLFW)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11" )
add_executable(flutter_glfw FlutterEmbedderGLFW.cc)
find_package(PkgConfig)
pkg_check_modules(GLFW3 REQUIRED IMPORTED_TARGET glfw3)
include_directories("$ENV{FLUTTER_ENGINE_SRC}/shell/platform/embedder")
find_library(FLUTTER_LIB FlutterEmbedder PATHS $ENV{FLUTTER_ENGINE_LIB})
target_link_libraries(flutter_glfw ${FLUTTER_LIB} PkgConfig::GLFW3)

# Copy the flutter library here since the shared library
# name is `./libflutter_engine.dylib`.
add_custom_command(
        TARGET flutter_glfw POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy
                ${FLUTTER_LIB}
                ${CMAKE_CURRENT_BINARY_DIR})
