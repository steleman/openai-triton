if (UNIX AND NOT APPLE)
  if ("${ROCTRACER_PREFIX}" STREQUAL "")
    set(ROCTRACER_PREFIX "/opt/rocm")
  endif()
endif()

message(STATUS "ROCTRACER_PREFIX: ${ROCTRACER_PREFIX}")

find_path(ROCTRACER_TOOLKIT
  NAMES .info
  HINTS ${ROCTRACER_PREFIX}
  REQUIRED
)

message(STATUS "ROCTRACER_TOOLKIT: ${ROCTRACER_TOOLKIT}")

find_path(ROCTRACER_INCLUDE_DIR
  NAMES roctracer/roctracer_hip.h
  HINTS ${ROCTRACER_TOOLKIT}/include
        ${ROCTRACER_TOOLKIT}
  # PATH_SUFFIXES roctracer
  REQUIRED)

mark_as_advanced(ROCTRACER_INCLUDE_DIR)
message(STATUS "ROCTRACER_INCLUDE_DIR: ${ROCTRACER_INCLUDE_DIR}")

find_path(ROCTRACER_HEADERS
  NAMES roctracer.h
  HINTS ${ROCTRACER_INCLUDE_DIR}/roctracer
  REQUIRED)

mark_as_advanced(ROCTRACER_HEADERS)
message(STATUS "ROCTRACER_HEADERS: ${ROCTRACER_HEADERS}")

find_library(ROCTRACER_LIBRARY
  NAMES roctracer64
  HINTS ${ROCTRACER_TOOLKIT}
        ${ROCTRACER_TOOLKIT}/lib
        ${ROCTRACER_TOOLKIT}/lib64
  REQUIRED)

mark_as_advanced(ROCTRACER_LIBRARY)
message(STATUS "ROCTRACER_LIBRARY: ${ROCTRACER_LIBRARY}")

if(ROCTRACER_INCLUDE_DIR)
  file(READ "${ROCTRACER_INCLUDE_DIR}/roctracer/roctracer.h" header)
  string(REGEX MATCH "#define ROCTRACER_VERSION_MAJOR [0-9]+" macroMajor "${header}")
  string(REGEX MATCH "[0-9]+" versionMajor "${macroMajor}")
  string(REGEX MATCH "#define ROCTRACER_VERSION_MINOR [0-9]+" macroMinor "${header}")
  string(REGEX MATCH "[0-9]+" versionMinor "${macroMinor}")
  set(ROCTRACER_VERSION "${versionMajor}.${versionMinor}")
else()
  message(FATAL_ERROR "Could not find ROCm's include directory.")
endif()


include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(ROCTRACER
  FOUND_VAR ROCTRACER_FOUND
  REQUIRED_VARS
    ROCTRACER_TOOLKIT
    ROCTRACER_INCLUDE_DIR
    ROCTRACER_LIBRARY
  VERSION_VAR ROCTRACER_VERSION
)

if(ROCTRACER_FOUND)
  add_library(ROCTRACER::ROCTRACER UNKNOWN IMPORTED)
  set_target_properties(ROCTRACER::ROCTRACER PROPERTIES
    IMPORTED_LOCATION "${ROCTRACER_LIBRARY}")
  target_include_directories(ROCTRACER::ROCTRACER INTERFACE "${ROCTRACER_INCLUDE_DIR}")

  # In ROCm 5.1, ROCTRACER also requires the roctracer/ subdirectory to be
  # available on the include paths. We use a compile test to determine if
  # this is needed at all.
  include(CheckIncludeFile)
  check_include_file("roctracer/roctracer_hip.h" ROCTRACER_GOOD_HEADERS
    CMAKE_REQUIRED_INCLUDES "${ROCTRACER_INCLUDE_DIR}")
  if(NOT ROCTRACER_GOOD_HEADERS)
    message(STATUS "Adding ${ROCTRACER_HEADERS} to include headers")
    target_include_directories(ROCTRACER::ROCTRACER INTERFACE "${ROCTRACER_HEADERS}")
  endif()
endif()

mark_as_advanced(
  ROCTRACER_INCLUDE_DIR
  ROCTRACER_HEADERS
  ROCTRACER_LIBRARY
  ROCTRACER_GOOD_HEADERS
)

