add_triton_library(TritonAnalysis
  AxisInfo.cpp
  Allocation.cpp
  Membar.cpp
  Alias.cpp
  Utility.cpp

  DEPENDS
  TritonTableGenCustomTarget
  TritonGPUTableGenCustomTarget
  TritonGPUAttrDefsIncGenCustomTarget
  TritonGPUTypeInterfacesIncGenCustomTarget

  LINK_LIBS PUBLIC
  MLIRAnalysis
  MLIRLLVMDialect
  TritonIR
  TritonGPUIR
  TritonNvidiaGPUIR
)
