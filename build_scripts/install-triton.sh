#!/bin/bash

here="`pwd`"
topdir="`dirname ${here}`"
basehere="`basename ${here}`"
tritondir="${topdir}/triton-gpu"

llvm_version="21.1.1"
prefix="/opt/triton/llvm-${llvm_version}"
llvm="${prefix}"
cuda_version="12.9"
cuda="/usr/local/cuda-${cuda_version}"
rocm_version="6.4.3"
rocm="/opt/rocm-${rocm_version}"
llvmbindir="${llvm}/bin"
llvmlibdir="${llvm}/lib64"
llvmincdir="${llvm}/include"
llvmbuilddir="${topdir}/triton-llvm-build"
llvmbuildbindir="${topdir}/triton-llvm-build/bin"
destdir="${topdir}/install-triton-gpu"
opttriton="${destdir}/opt/triton/llvm-${llvm_version}"
tritonbindir=${opttriton}/bin
tritonlibdir=${opttriton}/lib64
tritonincdir=${opttriton}/include
tritonsharedir=${opttriton}/share
tritontestdir=${opttriton}/test
protondir="${topdir}/proton"
runpath="${prefix}/lib64:${cuda}/lib64:${cuda}/targets/`arch`-linux/lib"
runpath="${runpath}:${rocm}/lib"

if [ "${basehere}" != "build-triton" ] ; then
  echo "You are in the wrong build directory."
  exit 1
fi

if [ ! -d ${destdir} ] ; then
  mkdir -p ${destdir}
  mkdir -p ${opttriton}
fi

outfile="${here}/install-triton-gpu.log"

export PATH="${cuda}/bin:${rocm}/bin:${llvmbuildbindir}:${llvmbindir}:/usr/local/bin:/usr/bin:/usr/sbin:${here}/bin"
export LD_LIBRARY_PATH="${here}/lib:${here}/lib64"

if [ ! -d ${destdir} ] ; then
  echo "mkdir -p ${destdir}"
  mkdir -p ${destdir}
fi

echo "mkdir -p ${tritonbindir}"
mkdir -p ${tritonbindir}

echo "mkdir -p ${tritonlibdir}"
mkdir -p ${tritonlibdir}

echo "mkdir -p ${tritonincdir}"
mkdir -p ${tritonincdir}

echo "mkdir -p ${tritonsharedir}"
mkdir -p ${tritonsharedir}

echo "mkdir -p ${tritontestdir}"
mkdir -p ${tritontestdir}

cat /dev/null > ${outfile}
echo "Running gmake DESTDIR=${destdir} install >> ${outfile} 2>&1"
gmake DESTDIR=${destdir} install >> ${outfile} 2>&1

if [ -e ${here}/libtriton.so ] ; then
  patchelf --set-rpath ${runpath} ${here}/libtriton.so
  cp -f ${here}/libtriton.so ${here}/lib/
  cp -f ${here}/libtriton.so ${tritonlibdir}/
fi

if [ -d ${here}/bin ] ; then
  cd ${here}/bin
  for file in \
    triton-opt \
    triton-reduce \
    triton-lsp \
    triton-llvm-opt \
    triton-tensor-layout
  do
    patchelf --set-rpath ${runpath} ${file}
    cp -f ${file} ${tritonbindir}/
  done
fi

cd ${here}

cp -f ${here}/third_party/amd/test/lib/Analysis/libTritonAMDGPUTestAnalysis.a \
  ${tritonlibdir}/

patchelf --set-rpath ${runpath} \
  ${here}/third_party/amd/unittest/Conversion/TestOptimizeLDS
cp -f ${here}/third_party/amd/unittest/Conversion/TestOptimizeLDS ${tritontestdir}/


for file in \
  TestSwizzling \
  Dialect \
  LinearLayoutConversions \
  DumpLayoutTest
do
  patchelf --set-rpath ${runpath} ${here}/unittest/Dialect/TritonGPU/${file}
  cp -f ${here}/unittest/Dialect/TritonGPU/${file} ${tritontestdir}/
done

patchelf --set-rpath ${runpath} ${here}/unittest/Analysis/TestTritonAnalysis
cp -f ${here}/unittest/Analysis/TestTritonAnalysis ${tritontestdir}/

patchelf --set-rpath ${runpath} ${here}/unittest/Tools/LinearLayout
cp -f ${here}/unittest/Tools/LinearLayout ${tritontestdir}/

patchelf --set-rpath ${runpath} \
  ${here}/test/lib/Instrumentation/libGPUInstrumentationTestLib.so

cp -f ${here}/test/lib/Instrumentation/libGPUInstrumentationTestLib.so \
  ${tritonlibdir}/

patchelf --set-rpath ${runpath} \
  ${here}/lib/Instrumentation/libPrintLoadStoreMemSpaces.so
cp -f ${here}/lib/Instrumentation/libPrintLoadStoreMemSpaces.so \
  ${tritonlibdir}/

patchelf --set-rpath ${runpath} \
  ${here}/third_party/proton/libproton.so
cp -f ${here}/third_party/proton/libproton.so ${tritonlibdir}/

cp -f ${protondir}/proton ${tritonbindir}/
cp -f ${protondir}/proton-viewer ${tritonbindir}/

cd ${tritonbindir}
rm -rf CMakeFiles cmake_install.cmake CTestTestfile.cmake Makefile

cd ${here}

echo "cp -rd ${here}/include/triton ${tritonincdir}/"
cp -rd ${here}/include/triton ${tritonincdir}/

echo "cd ${tritonincdir}/triton"
cd ${tritonincdir}/triton

find . -type d -name 'CMakeFiles' -exec rm -rf {} \; -print > /dev/null 2>&1
find . -type f -name 'Makefile' -exec rm -f {} \; -print > /dev/null 2>&1
find . -type f -name "*.cmake" -exec rm -f {} \; -print > /dev/null 2>&1

cd ${tritonlibdir}

for file in \
  libgtest.a \
  libgmock_main.a \
  libgmock.a \
  libgtest_main.a
do
  rm -f ${file}
done

rm -rf cmake

cd ${tritonincdir}

rm -rf gmock gtest

cd ${here}


