cmake_minimum_required(VERSION 3.14)

project(greetness2Tests LANGUAGES CXX)

include(../cmake/project-is-top-level.cmake)
include(../cmake/folders.cmake)

# ---- Dependencies ----

if(PROJECT_IS_TOP_LEVEL)
  find_package(greetness2 REQUIRED)
  enable_testing()
endif()

find_package(Catch2 REQUIRED)
include(Catch)

# ---- Tests ----

add_executable(greetness2_test source/greetness2_test.cpp)
target_link_libraries(
    greetness2_test PRIVATE
    greetness2::greetness2
    Catch2::Catch2WithMain
)
target_compile_features(greetness2_test PRIVATE cxx_std_17)

catch_discover_tests(greetness2_test)

# ---- End-of-file commands ----

add_folders(Test)
