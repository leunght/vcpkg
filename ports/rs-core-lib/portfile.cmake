include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO CaptainCrowbar/rs-core-lib
    REF 65c312231cc9ea46eacb4ae76a8ba075f8b1a2c1
    SHA512 262aa0bf424363b09e51cd5ae6ce5fd57cc30b830d0cd6118b462641f07a39742646f75a37e49a2629405b17c7b7260c7e076fa02f093c5fda84166383ca9572
    HEAD_REF master
)

file(INSTALL ${SOURCE_PATH}/rs-core DESTINATION ${CURRENT_PACKAGES_DIR}/include FILES_MATCHING PATTERN "*.hpp")

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE.TXT DESTINATION ${CURRENT_PACKAGES_DIR}/share/rs-core-lib RENAME copyright)