set(LLVM_TARGET_DEFINITIONS Passes.td)
mlir_tablegen(Passes.h.inc -gen-pass-decls -name TritonAMDGPU)
add_public_tablegen_target(TritonAMDGPUTransformsIncGen)
add_custom_target(TritonAMDGPUTransformsIncGenCustomTarget
                  COMMAND /bin/true
                  DEPENDS Passes.h.inc
                  BYPRODUCTS Passes.h.inc)

