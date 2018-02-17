# Automatically generated by boost-vcpkg-helpers/generate-ports.ps1

include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/uuid
    REF boost-1.66.0
    SHA512 5fc333c76f4d44fcbca4a7be02117015e361b85c615d3f728d9805d32f55431fca33f90bb0151a789b341606d8ce7538163a162a4c7ba29823cf7a01326685d7
    HEAD_REF master
)

include(${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
