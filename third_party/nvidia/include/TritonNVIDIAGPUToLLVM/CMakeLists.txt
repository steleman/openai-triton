set(LLVM_TARGET_DEFINITIONS Passes.td)
mlir_tablegen(Passes.h.inc -gen-pass-decls --name TritonNVIDIAGPUToLLVM)
add_public_tablegen_target(TritonNVIDIAGPUConversionPassIncGen)
add_custom_target(TritonNVIDIAGPUConversionPassIncGenCustomTarget
                  COMMAND /bin/true
                  DEPENDS Passes.h.inc
                  BYPRODUCTS Passes.h.inc)

