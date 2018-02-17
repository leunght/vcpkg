# Automatically generated by boost-vcpkg-helpers/generate-ports.ps1

include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/serialization
    REF boost-1.66.0
    SHA512 8d4908a1eba309c8e752f07e123d0c6d461e3ce87db3b3afbf4ae56340c1ead6ac874be392d8270b167be28d7dc515f98abece091b081fd4794cb375f9779880
    HEAD_REF master
)

include(${CURRENT_INSTALLED_DIR}/share/boost-build/boost-modular-build.cmake)
boost_modular_build(SOURCE_PATH ${SOURCE_PATH})
include(${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
