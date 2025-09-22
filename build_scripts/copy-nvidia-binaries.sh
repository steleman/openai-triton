#!/bin/bash

here="`pwd`"
cuda_version="12.9"
cuda_root="/usr/local/cuda-${cuda_version}"
cuda_bindir="${cuda_root}/bin"
cuda_libdir="${cuda_root}/lib64"
cuda_target_libdir="${cuda_root}/targets/`arch`-linux/lib"

destdir="${here}/third_party/nvidia/backend"
bindir="${destdir}/bin"
libdir="${destdir}/lib"
cuptilibdir="${destdir}/lib/cupti"

if [ ! -d ${bindir} ] ; then
  mkdir -p ${bindir}
fi

if [ ! -d ${libdir} ] ; then
  mkdir -p ${libdir}
fi

if [ ! -d ${cuptilibdir} ] ; then
  mkdir -p ${cuptilibdir}
fi

for file in \
  ptxas \
  cuobjdump \
  nvdisasm
do
  if [ -e ${cuda_bindir}/${file} ] ; then
    echo "Copying ${file} from ${cuda_bindir}"
    rm -f ${bindir}/${file}
    cp -fp ${cuda_bindir}/${file} ${bindir}/
  fi
done

rm -f ${libdir}/libcupti.so.12
rm -f ${libdir}/libcupti.so

for file in \
  libpcsamplingutil.so \
  libnvperf_target.so \
  libnvperf_host_static.a \
  libnvperf_host.so \
  libcupti_static.a \
  libcupti.so.2025.1.1 \
  libcupti.so.2025.2.1 \
  libcheckpoint.so
do
  if [ -e ${cuda_target_libdir}/${file} ] ; then
    echo "Copying ${file} from ${cuda_target_libdir}"
    rm -f ${libdir}/${file}
    rm -f ${cuptilibdir}/${file}
    cp -fp ${cuda_target_libdir}/${file} ${cuptilibdir}/
    continue
  fi

  if [ -e ${cuda_libdir}/${file} ] ; then
    echo "Copying ${file} from ${cuda_libdir}"
    rm -f ${libdir}/${file}
    rm -f ${cuptilibdir}/${file}
    cp -fp ${cuda_libdir}/${file} ${cuptilibdir}/
    continue
  fi
done

if [ -e ${cuda_root}/nnvm/libdevice/libdevice.10.bc ] ; then
  echo "Copying libdevice.10.bc"
  rm -f ${libdir}/libdevice.10.bc
  cp -fp ${cuda_root}/nnvm/libdevice/libdevice.10.bc ${libdir}/
fi

cd ${cuptilibdir}
ln -sf libcupti.so.2025.2.1 libcupti.so.12
ln -sf libcupti.so.2025.2.1 libcupti.so
cd ${here}

