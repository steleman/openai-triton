set(LLVM_TARGET_DEFINITIONS Passes.td)
mlir_tablegen(Passes.h.inc -gen-pass-decls --name TritonGPUToLLVM)
add_public_tablegen_target(TritonGPUConversionPassIncGen)
add_custom_target(TritonGPUConversionPassIncGenCustomTarget
                  COMMAND /bin/true
                  DEPENDS Passes.h.inc
                  BYPRODUCTS Passes.h.inc)

