#!/bin/bash

ARMNN_SOURCE_DIR=$INSTALL_DIR/$PACKAGE_SUB_DIR
ARMNN_BUILD_DIR=$INSTALL_DIR/obj
export ARMNN_TARGET_DIR=$INSTALL_DIR/install

rm -rf "${ARMNN_BUILD_DIR}"
mkdir ${ARMNN_BUILD_DIR}
cd ${ARMNN_BUILD_DIR}

CXX=${CK_CXX} \
CC="${CK_CC} ${CK_COMPILER_FLAGS_OBLIGATORY} ${CK_CC_FLAGS_FOR_CMAKE} ${CK_CC_FLAGS_ANDROID_TYPICAL} ${EXTRA_FLAGS}" \
cmake ${ARMNN_SOURCE_DIR} \
    -DBoost_NO_BOOST_CMAKE=ON \
    -DBOOST_ROOT=${CK_ENV_LIB_BOOST} \
    -DCMAKE_LINKER="${CK_LD_PATH_FOR_CMAKE}" \
    -DCMAKE_EXE_LINKER_FLAGS="${CK_LINKER_FLAGS_ANDROID_TYPICAL}  ${CK_COMPILER_FLAG_PTHREAD_LIB}" \
    -DCMAKE_CROSSCOMPILING="TRUE" \
    -DCMAKE_INSTALL_PREFIX:PATH="${ARMNN_TARGET_DIR}" \

make -j32
