add_triton_library(TritonNvidiaGPUIR
  Dialect.cpp
  Ops.cpp
  DEPENDS
  TritonNvidiaGPUTableGenCustomTarget
  TritonNvidiaGPUAttrDefsIncGenCustomTarget
  TritonNvidiaGPUOpInterfacesIncGenCustomTarget
  LINK_LIBS PUBLIC
  TritonIR
  TritonGPUIR
)
