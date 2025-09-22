add_triton_library(NVGPUIR
  Dialect.cpp

  DEPENDS
  NVWSTableGen
  NVWSAttrDefsIncGen
  NVWSTransformsIncGen
  NVGPUTableGen
  NVGPUAttrDefsIncGen
  TritonNVIDIAGPUConversionPassIncGen

  LINK_LIBS PUBLIC
  MLIRLLVMDialect
)
