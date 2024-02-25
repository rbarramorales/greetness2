if(PROJECT_IS_TOP_LEVEL)
  set(
      CMAKE_INSTALL_INCLUDEDIR "include/greetness2-${PROJECT_VERSION}"
      CACHE STRING ""
  )
  set_property(CACHE CMAKE_INSTALL_INCLUDEDIR PROPERTY TYPE PATH)
endif()

include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

# find_package(<package>) call for consumers to find this project
set(package greetness2)

install(
    DIRECTORY
    include/
    "${PROJECT_BINARY_DIR}/export/"
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
    COMPONENT greetness2_Development
)

install(
    TARGETS greetness2_greetness2
    EXPORT greetness2Targets
    RUNTIME #
    COMPONENT greetness2_Runtime
    LIBRARY #
    COMPONENT greetness2_Runtime
    NAMELINK_COMPONENT greetness2_Development
    ARCHIVE #
    COMPONENT greetness2_Development
    INCLUDES #
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
)

write_basic_package_version_file(
    "${package}ConfigVersion.cmake"
    COMPATIBILITY SameMajorVersion
)

# Allow package maintainers to freely override the path for the configs
set(
    greetness2_INSTALL_CMAKEDIR "${CMAKE_INSTALL_LIBDIR}/cmake/${package}"
    CACHE STRING "CMake package config location relative to the install prefix"
)
set_property(CACHE greetness2_INSTALL_CMAKEDIR PROPERTY TYPE PATH)
mark_as_advanced(greetness2_INSTALL_CMAKEDIR)

install(
    FILES cmake/install-config.cmake
    DESTINATION "${greetness2_INSTALL_CMAKEDIR}"
    RENAME "${package}Config.cmake"
    COMPONENT greetness2_Development
)

install(
    FILES "${PROJECT_BINARY_DIR}/${package}ConfigVersion.cmake"
    DESTINATION "${greetness2_INSTALL_CMAKEDIR}"
    COMPONENT greetness2_Development
)

install(
    EXPORT greetness2Targets
    NAMESPACE greetness2::
    DESTINATION "${greetness2_INSTALL_CMAKEDIR}"
    COMPONENT greetness2_Development
)

if(PROJECT_IS_TOP_LEVEL)
  include(CPack)
endif()
