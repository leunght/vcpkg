if (VCPKG_LIBRARY_LINKAGE STREQUAL static)
    set(VCPKG_LIBRARY_LINKAGE dynamic)
    message("Static building not supported yet")
endif()

if (NOT VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
    message(FATAL_ERROR "This portfile only supports UWP")
endif()

if (VCPKG_TARGET_ARCHITECTURE STREQUAL "arm")
    set(UWP_PLATFORM  "arm")
elseif (VCPKG_TARGET_ARCHITECTURE STREQUAL "x64")
    set(UWP_PLATFORM  "x64")
elseif (VCPKG_TARGET_ARCHITECTURE STREQUAL "x86")
    set(UWP_PLATFORM  "Win32")
else ()
    message(FATAL_ERROR "Unsupported architecture")
endif()

include(vcpkg_common_functions)

vcpkg_find_acquire_program(PERL)
vcpkg_find_acquire_program(JOM)
get_filename_component(JOM_EXE_PATH ${JOM} DIRECTORY)
get_filename_component(PERL_EXE_PATH ${PERL} DIRECTORY)
set(ENV{PATH} "$ENV{PATH};${PERL_EXE_PATH};${JOM_EXE_PATH}")

vcpkg_from_github(
    OUT_SOURCE_PATH MASTER_SOURCE_PATH
    REPO Microsoft/openssl
    REF OpenSSL_1_0_2l_WinRT
    SHA512 aa3eafbff72a246ac45af059d549450e8589cb594fd8a714e92dc0390f9874b0e9510d4878fe38792733f80acc05f9a550f549c399990b769715c42949d2f4bf
    HEAD_REF OpenSSL_1_0_2_WinRT-stable
    PATCHES
        ${CMAKE_CURRENT_LIST_DIR}/fix-uwp-rs4.patch
        ${CMAKE_CURRENT_LIST_DIR}/ConfigureIncludeQuotesFix.patch
        ${CMAKE_CURRENT_LIST_DIR}/STRINGIFYPatch.patch
        ${CMAKE_CURRENT_LIST_DIR}/EmbedSymbolsInStaticLibsZ7.patch
)

set(SOURCE_PATH_BASE ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel)
file(REMOVE_RECURSE ${SOURCE_PATH})

file(COPY ${MASTER_SOURCE_PATH} DESTINATION ${SOURCE_PATH_BASE})
get_filename_component(MASTER_SOURCE_PATH_NAME "${MASTER_SOURCE_PATH}" NAME)
set(SOURCE_PATH ${SOURCE_PATH_BASE}/${MASTER_SOURCE_PATH_NAME})

file(REMOVE_RECURSE ${SOURCE_PATH}/tmp32dll)
file(REMOVE_RECURSE ${SOURCE_PATH}/out32dll)
file(REMOVE_RECURSE ${SOURCE_PATH}/inc32dll)

file(
    COPY ${CMAKE_CURRENT_LIST_DIR}/make-openssl.bat
    DESTINATION ${SOURCE_PATH}
)

message(STATUS "Build ${TARGET_TRIPLET}")
vcpkg_execute_required_process(
    COMMAND ${SOURCE_PATH}/make-openssl.bat ${UWP_PLATFORM}
    WORKING_DIRECTORY ${SOURCE_PATH}
    LOGNAME make-openssl-${TARGET_TRIPLET}
)
message(STATUS "Build ${TARGET_TRIPLET} done")

file(
    COPY ${SOURCE_PATH}/inc32/openssl
    DESTINATION ${CURRENT_PACKAGES_DIR}/include
)

file(INSTALL
    ${SOURCE_PATH}/out32dll/libeay32.dll
    ${SOURCE_PATH}/out32dll/libeay32.pdb
    ${SOURCE_PATH}/out32dll/ssleay32.dll
    ${SOURCE_PATH}/out32dll/ssleay32.pdb
    DESTINATION ${CURRENT_PACKAGES_DIR}/bin)

file(INSTALL
    ${SOURCE_PATH}/out32dll/libeay32.lib
    ${SOURCE_PATH}/out32dll/ssleay32.lib
    DESTINATION ${CURRENT_PACKAGES_DIR}/lib)

file(INSTALL
    ${SOURCE_PATH}/out32dll/libeay32.dll
    ${SOURCE_PATH}/out32dll/libeay32.pdb
    ${SOURCE_PATH}/out32dll/ssleay32.dll
    ${SOURCE_PATH}/out32dll/ssleay32.pdb
    DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)

file(INSTALL
    ${SOURCE_PATH}/out32dll/libeay32.lib
    ${SOURCE_PATH}/out32dll/ssleay32.lib
    DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/openssl-uwp RENAME copyright)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/usage DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})
