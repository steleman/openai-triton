#!/bin/bash

here="`pwd`"
tophere="`dirname ${here}`"
llvmbuilddir="${tophere}/triton-llvm-build"
cuda_version="12.9"
rocm_version="6.4.3"

export CUDA_PREFIX="/usr/local/cuda-${cuda_version}"
export CUDA_TOOLKIT_ROOT_DIR="${CUDA_PREFIX}"
export ROCTRACER_PREFIX="/opt/rocm-${rocm_version}"
export CUDA_INCLUDE_DIR="${CUDA_PREFIX}/include"
export CUDA_LIBRARY_DIR="${CUDA_PREFIX}/lib64"
export CUPTI_INCLUDE_DIR="${CUDA_PREFIX}/targets/`arch`-linux/include"
export CUPTI_LIB_DIR="${CUDA_PREFIX}/targets/`arch`-linux/lib"
export ROCM_TOOLKIT_ROOT_DIR="/opt/rocm-${rocm_version}"
export PATH="${llvmbuilddir}/bin:${CUDA_TOOLKIT_ROOT_DIR}/bin:${ROCM_TOOLKIT_ROOT_DIR}/bin:${PATH}"
export LLVM_INCLUDE_DIRS="${llvmbuilddir}/include"
export LLVM_LIBRARY_DIR="${llvmbuilddir}/lib64"
export LLVM_SYSPATH="${llvmbuilddir}"
export LLVM_EXTERNAL_LIT="${llvmbuilddir}/bin"

export TRITON_BUILD_WITH_CLANG_LLD="false"
export TRITON_BUILD_WITH_CCACHE="false"
export TRITON_BUILD_PROTON="ON"
export TRITON_CUPTI_INCLUDE_PATH="${CUDA_TOOLKIT_ROOT_DIR}/include"
export JSON_INCLUDE_DIR="/usr/include"

export CC="/usr/bin/gcc"
export CXX="/usr/bin/g++"
export CFLAGS="-O2 -std=gnu11 -Wall -Wextra"
export CXXFLAGS="-O2 -std=gnu++17 -Wall -Wextra"
export BUILD_TYPE="Release"
export MAX_JOBS=1
export TRITON_OFFLINE_BUILD=1

if [ -d ${here}/build ] ; then
  echo "rm -rf ${here}/build"
  rm -rf ${here}/build
fi

if [ -d ${here}/dist ] ; then
  echo "rm -rf ${here}/dist"
  rm -rf ${here}/dist
fi

outfile="${here}/pip3-cleanup-triton-wheel.log"

cat /dev/null > ${outfile}

echo "python3 ./setup.py clean >> ${outfile} 2>&1"
python3 ./setup.py clean >> ${outfile} 2>&1

find . -type d -name '__pycache__' -exec rm -rf {} \; -print > /dev/null 2>&1


