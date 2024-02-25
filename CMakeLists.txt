cmake_minimum_required(VERSION 3.14)

include(cmake/prelude.cmake)

project(
    greetness2
    VERSION 0.1.0
    DESCRIPTION "Testing cmake-init library with vcpkg"
    HOMEPAGE_URL "https://github.com/rbarramorales/greatness"
    LANGUAGES CXX
)

include(cmake/project-is-top-level.cmake)
include(cmake/variables.cmake)

# ---- Declare library ----

add_library(
    greetness2_greetness2
    source/greetness2.cpp
)
add_library(greetness2::greetness2 ALIAS greetness2_greetness2)

include(GenerateExportHeader)
generate_export_header(
    greetness2_greetness2
    BASE_NAME greetness2
    EXPORT_FILE_NAME export/greetness2/greetness2_export.hpp
    CUSTOM_CONTENT_FROM_VARIABLE pragma_suppress_c4251
)

if(NOT BUILD_SHARED_LIBS)
  target_compile_definitions(greetness2_greetness2 PUBLIC GREETNESS2_STATIC_DEFINE)
endif()

set_target_properties(
    greetness2_greetness2 PROPERTIES
    CXX_VISIBILITY_PRESET hidden
    VISIBILITY_INLINES_HIDDEN YES
    VERSION "${PROJECT_VERSION}"
    SOVERSION "${PROJECT_VERSION_MAJOR}"
    EXPORT_NAME greetness2
    OUTPUT_NAME greetness2
)

target_include_directories(
    greetness2_greetness2 ${warning_guard}
    PUBLIC
    "\$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>"
)

target_include_directories(
    greetness2_greetness2 SYSTEM
    PUBLIC
    "\$<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/export>"
)

target_compile_features(greetness2_greetness2 PUBLIC cxx_std_17)

find_package(fmt REQUIRED)
target_link_libraries(greetness2_greetness2 PRIVATE fmt::fmt)

# ---- Install rules ----

if(NOT CMAKE_SKIP_INSTALL_RULES)
  include(cmake/install-rules.cmake)
endif()

# ---- Examples ----

if(PROJECT_IS_TOP_LEVEL)
  option(BUILD_EXAMPLES "Build examples tree." "${greetness2_DEVELOPER_MODE}")
  if(BUILD_EXAMPLES)
    add_subdirectory(example)
  endif()
endif()

# ---- Developer mode ----

if(NOT greetness2_DEVELOPER_MODE)
  return()
elseif(NOT PROJECT_IS_TOP_LEVEL)
  message(
      AUTHOR_WARNING
      "Developer mode is intended for developers of greetness2"
  )
endif()

include(cmake/dev-mode.cmake)
