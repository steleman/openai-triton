#!/bin/bash

here="`pwd`"
tophere="`dirname ${here}`"
outfile="${here}/build-triton.log"
rocm_version="6.4.3"
cuda_version="12.9"
llvm_version="21.1.1"
njobs="1"

export LLVM_TRITON_BUILD_DIR="${tophere}/triton-llvm-build"
export TRITON_BUILD_DIR="${tophere}/build-triton"
export LLVM_DIR="/opt/triton/llvm-${llvm_version}"

if [ ! -d ${LLVM_TRITON_BUILD_DIR} ] ; then
  echo "LLVM Triton Build Directory does not exist."
  exit 1
fi

if [ ! -d ${TRITON_BUILD_DIR} ] ; then
  echo "Triton Build Directory does not exist."
  exit 1
fi

export LD_LIBRARY_PATH="${LLVM_DIR}/lib64:${LLVM_TRITON_BUILD_DIR}/lib64:${here}/lib64:${here}/lib"
export CUDATOP="/usr/local/cuda-${cuda_version}"
export ROCMTOP="/opt/rocm-${rocm_version}"
export PATH="${CUDATOP}/bin:${ROCMTOP}/bin:${LLVM_DIR}/bin:${LLVM_TRITON_BUILD_DIR}/bin:${PATH}"

cat /dev/null > ${outfile}
echo "gmake >> ${outfile} 2>&1"
gmake >> ${outfile} 2>&1

