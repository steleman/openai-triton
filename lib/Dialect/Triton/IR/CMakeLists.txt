set(LLVM_TARGET_DEFINITIONS Canonicalize.td)
mlir_tablegen(TritonCanonicalize.inc -gen-rewriters)
add_public_tablegen_target(TritonCanonicalizeIncGen)
add_custom_target(TritonCanonicalizeIncGenCustomTarget
                  COMMAND /bin/true
                  DEPENDS TritonCanonicalize.inc
                  BYPRODUCTS TritonCanonicalize.inc)

add_triton_library(TritonIR
  Dialect.cpp
  Ops.cpp
  Traits.cpp
  Types.cpp
  OpInterfaces.cpp
  Utility.cpp

  DEPENDS
  TritonTableGenCustomTarget
  TritonCanonicalizeIncGenCustomTarget

  LINK_LIBS PUBLIC
  MLIRIR
  MLIRArithDialect
  MLIRMathDialect
  MLIRSCFDialect
)
