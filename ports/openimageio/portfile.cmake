include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO OpenImageIO/oiio
    REF Release-1.9.3dev
    SHA512 c218f524cd4242d33400f4df8fc6acd66d0ceba12640fb2b3870c7d774a9e991ce59b13a7a96878aaf82ab44059bd8a40b286d812e2c2a8b6a090d68196f4190
    HEAD_REF master
)

file(REMOVE_RECURSE "${SOURCE_PATH}/ext")
file(MAKE_DIRECTORY "${SOURCE_PATH}/ext/robin-map/tsl")

if(VCPKG_LIBRARY_LINKAGE STREQUAL static)
    set(BUILDSTATIC ON)
    set(LINKSTATIC ON)
else()
    set(BUILDSTATIC OFF)
    set(LINKSTATIC OFF)
endif()

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DOIIO_BUILD_TOOLS=OFF
        -DOIIO_BUILD_TESTS=OFF
        -DHIDE_SYMBOLS=ON
        -DUSE_FFMPEG=OFF
        -DUSE_FIELD3D=OFF
        -DUSE_FREETYPE=OFF
        -DUSE_GIF=OFF
        -DUSE_LIBRAW=OFF
        -DUSE_NUKE=OFF
        -DUSE_OCIO=OFF
        -DUSE_OPENCV=OFF
        -DUSE_OPENJPEG=OFF
        -DUSE_PTEX=OFF
        -DUSE_PYTHON=OFF
        -DUSE_QT=OFF
        -DBUILDSTATIC=${BUILDSTATIC}
        -DLINKSTATIC=${LINKSTATIC}
        -DBUILD_MISSING_PYBIND11=OFF
        -DBUILD_MISSING_DEPS=OFF
        -DCMAKE_DISABLE_FIND_PACKAGE_Git=ON
)

vcpkg_install_cmake()

vcpkg_copy_pdbs()

# Clean
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/doc)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/doc)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

# Handle copyright
file(COPY ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/openimageio)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/openimageio/LICENSE ${CURRENT_PACKAGES_DIR}/share/openimageio/copyright)
