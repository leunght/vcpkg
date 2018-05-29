#header-only library
include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Microsoft/GSL
    REF 75ad0c1b40d27a2d0749861df923cb38f866a6c2
    SHA512 fdcc00b1420b97d32344c4b65c88a57fceb30055e63e7df16266e0417f12d5b8233568b3d23c888ad17b1d8eb1303ba477f3bb24a03df280c68db2c9f41e8d63
    HEAD_REF master
)

file(INSTALL ${SOURCE_PATH}/include/ DESTINATION ${CURRENT_PACKAGES_DIR}/include)

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/ms-gsl RENAME copyright)
