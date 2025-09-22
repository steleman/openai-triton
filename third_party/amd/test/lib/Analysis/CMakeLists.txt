add_mlir_library(TritonAMDGPUTestAnalysis
  TestAMDRangeAnalysis.cpp
  TestAMDGPUMembar.cpp
  TestAxisInfo.cpp

  DEPENDS
  TritonTableGenCustomTarget
  TritonGPUTableGenCustomTarget
  TritonGPUAttrDefsIncGenCustomTarget
  TritonGPUTypeInterfacesIncGenCustomTarget

  LINK_LIBS PUBLIC
  MLIRPass
  ${triton_libs}
)
