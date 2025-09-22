add_triton_library(NVGPUToLLVM
    NVGPUToLLVMPass.cpp

    DEPENDS
    NVGPUTableGen
    NVGPUAttrDefsIncGen
    NVGPUConversionPassIncGen
    NVGPUIR
)
