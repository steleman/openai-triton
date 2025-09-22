set(LLVM_TARGET_DEFINITIONS Passes.td)
mlir_tablegen(Passes.h.inc -gen-pass-decls -name NVHopperTransforms)
add_public_tablegen_target(NVHopperTransformsIncGen)
add_custom_target(NVHopperTransformsIncGenCustomTarget
                  COMMAND /bin/true
                  DEPENDS Passes.h.inc
                  BYPRODUCTS Passes.h.inc)

