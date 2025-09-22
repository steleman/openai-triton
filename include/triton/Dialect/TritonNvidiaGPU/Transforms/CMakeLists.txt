set(LLVM_TARGET_DEFINITIONS Passes.td)
mlir_tablegen(Passes.h.inc -gen-pass-decls -name TritonNvidiaGPU)
add_public_tablegen_target(TritonNvidiaGPUTransformsIncGen)
add_custom_target(TritonNvidiaGPUTransformsIncGenCustomTarget
                  COMMAND /bin/true
                  DEPENDS Passes.h.inc
                  BYPRODUCTS Passes.h.inc)

