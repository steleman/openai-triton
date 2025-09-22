add_triton_library(NVWSIR
  Dialect.cpp
  Ops.cpp

  DEPENDS
  NVWSTableGen
  NVWSAttrDefsIncGen
  NVWSTransformsIncGen
  NVGPUTableGen
  NVGPUAttrDefsIncGen
  NVGPUConversionPassIncGen
  TritonNVIDIAGPUConversionPassIncGen

  LINK_LIBS PUBLIC
  TritonIR
  TritonGPUIR
)
