add_triton_library(TritonGPUIR
  Dialect.cpp
  LinearLayoutConversions.cpp
  LayoutUtility.cpp
  Ops.cpp
  Types.cpp

  DEPENDS
  TritonGPUTableGenCustomTarget
  TritonGPUAttrDefsIncGenCustomTarget
  TritonGPUTypeInterfacesIncGenCustomTarget
  TritonNvidiaGPUTableGenCustomTarget
  TritonNvidiaGPUAttrDefsIncGenCustomTarget
  TritonNvidiaGPUOpInterfacesIncGenCustomTarget
  NVHopperTransformsIncGenCustomTarget
  NVWSTableGenCustomTarget
  NVWSAttrDefsIncGenCustomTarget
  NVWSTransformsIncGenCustomTarget
  NVGPUTableGenCustomTarget
  NVGPUAttrDefsIncGenCustomTarget
  NVGPUConversionPassIncGenCustomTarget
  TritonNVIDIAGPUConversionPassIncGenCustomTarget
  TritonAMDGPUTableGenCustomTarget
  TritonAMDGPUAttrDefsIncGenCustomTarget
  TritonAMDGPUTransformsIncGenCustomTarget
  TritonAMDGPUConversionPassIncGenCustomTarget

  LINK_LIBS PUBLIC
  MLIRGPUDialect
  TritonIR
  TritonTools
)
