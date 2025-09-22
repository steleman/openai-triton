set(MLIR_BINARY_DIR ${CMAKE_BINARY_DIR})

set(LLVM_TARGET_DEFINITIONS TritonNvidiaGPUOps.td)
mlir_tablegen(Dialect.h.inc -gen-dialect-decls -dialect=ttng)
mlir_tablegen(Dialect.cpp.inc -gen-dialect-defs -dialect=ttng)
mlir_tablegen(Ops.h.inc -gen-op-decls)
mlir_tablegen(Ops.cpp.inc -gen-op-defs)
add_mlir_doc(TritonNvidiaGPUDialect TritonNvidiaGPUDialect dialects/ -gen-dialect-doc)
add_mlir_doc(TritonNvidiaGPUOps TritonNvidiaGPUOps dialects/ -gen-op-doc)
add_public_tablegen_target(TritonNvidiaGPUTableGen)
add_custom_target(TritonNvidiaGPUTableGenCustomTarget
                  COMMAND /bin/true
                  DEPENDS
                  Dialect.h.inc
                  Dialect.cpp.inc
                  Ops.h.inc
                  Ops.cpp.inc
                  BYPRODUCTS
                  Dialect.h.inc
                  Dialect.cpp.inc
                  Ops.h.inc
                  Ops.cpp.inc)

set(LLVM_TARGET_DEFINITIONS TritonNvidiaGPUAttrDefs.td)
mlir_tablegen(TritonNvidiaGPUAttrDefs.h.inc -gen-attrdef-decls)
mlir_tablegen(TritonNvidiaGPUAttrDefs.cpp.inc -gen-attrdef-defs)
mlir_tablegen(OpsEnums.h.inc -gen-enum-decls)
mlir_tablegen(OpsEnums.cpp.inc -gen-enum-defs)
add_public_tablegen_target(TritonNvidiaGPUAttrDefsIncGen)
add_custom_target(TritonNvidiaGPUAttrDefsIncGenCustomTarget
                  COMMAND /bin/true
                  DEPENDS
                  TritonNvidiaGPUAttrDefs.h.inc
                  TritonNvidiaGPUAttrDefs.cpp.inc
                  OpsEnums.h.inc
                  OpsEnums.cpp.inc
                  BYPRODUCTS
                  TritonNvidiaGPUAttrDefs.h.inc
                  TritonNvidiaGPUAttrDefs.cpp.inc
                  OpsEnums.h.inc
                  OpsEnums.cpp.inc)

set(LLVM_TARGET_DEFINITIONS TritonNvidiaGPUOpInterfaces.td)
mlir_tablegen(TritonNvidiaGPUOpInterfaces.h.inc -gen-op-interface-decls)
mlir_tablegen(TritonNvidiaGPUOpInterfaces.cpp.inc -gen-op-interface-defs)
add_public_tablegen_target(TritonNvidiaGPUOpInterfacesIncGen)
add_custom_target(TritonNvidiaGPUOpInterfacesIncGenCustomTarget
                  COMMAND /bin/true
                  DEPENDS
                  TritonNvidiaGPUOpInterfaces.h.inc
                  TritonNvidiaGPUOpInterfaces.cpp.inc
                  BYPRODUCTS
                  TritonNvidiaGPUOpInterfaces.h.inc
                  TritonNvidiaGPUOpInterfaces.cpp.inc)

