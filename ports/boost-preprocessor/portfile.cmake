# Automatically generated by boost-vcpkg-helpers/generate-ports.ps1

include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/preprocessor
    REF boost-1.66.0
    SHA512 233c46132d69499d96d8cf47fd41e7b80a558b43ace57a654be9bf4aad8c46907bf2fcc0e5698c0df4c8006bcd1e51a72b69c9269e128f360477481ff8cb2451
    HEAD_REF master
)

include(${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
