# Find CUPTI library/header

if (UNIX AND NOT APPLE)
  set(CUDA_TOOLKIT_ROOT_DIR "/usr/local/cuda-12")
endif()

find_path(CUPTI_PREFIX
  NAMES include/cupti.h
  HINTS
  ${CUDA_TOOLKIT_ROOT_DIR}
)

find_library(CUPTI_LIBRARY
  NAMES cupti
  HINTS
    ${CUPTI_PREFIX}/lib
    ${CUDA_TOOLKIT_ROOT_DIR}/lib64
    ${CUDA_TOOLKIT_ROOT_DIR}/lib
    ${CUDA_TOOLKIT_ROOT_DIR}/extras/CUPTI/lib
)

find_path(CUPTI_INCLUDE_DIR
  NAMES cupti.h
  HINTS
    ${CUPTI_PREFIX}/include
    ${CUDA_TOOLKIT_ROOT_DIR}/include
    ${CUDA_TOOLKIT_ROOT_DIR}/extras/CUPTI/include
)

include(FindPackageHandleStandardArgs)

find_package_handle_standard_args(CUPTI
  DEFAULT_MSG
  CUPTI_LIBRARY
  CUPTI_INCLUDE_DIR
)

mark_as_advanced(
  CUPTI_INCLUDE_DIR
  CUPTI_LIBRARY
)

