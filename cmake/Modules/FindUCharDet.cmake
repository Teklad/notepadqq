# FindRapidJSON.cmake
#
# Finds the uchardet library
#
# This will define the following variables
#
#    UCharDet_FOUND
#    UCharDet_INCLUDE_DIRS
#
# and the following imported targets
#
#     UCharDet::UCharDet
#
# Author: Justin Kinnaird (Teklad) <jkinnaird1991@gmail.com>

find_package(PkgConfig)
pkg_check_modules(PC_UCharDet QUIET uchardet)

find_path(UCharDet_INCLUDE_DIR
    NAMES uchardet.h
    PATHS ${PC_UCharDet_INCLUDE_DIRS}
    PATH_SUFFIXES uchardet
)

set(UCharDet_VERSION ${PC_UCharDet_VERSION})

mark_as_advanced(UCharDet_FOUND UCharDet_INCLUDE_DIR UCharDet_VERSION)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(UCharDet
    REQUIRED_VARS UCharDet_INCLUDE_DIR
    VERSION_VAR UCharDet_VERSION
)

if(UCharDet_FOUND)
    set(UCharDet_INCLUDE_DIRS ${UCharDet_INCLUDE_DIR})
endif()

if(UCharDet_FOUND AND NOT TARGET UCharDet::UCharDet)
    add_library(UCharDet::UCharDet INTERFACE IMPORTED)
    set_target_properties(UCharDet::UCharDet PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${UCharDet_INCLUDE_DIR}"
        INTERFACE_LINK_LIBRARIES "${PC_UCharDet_LIBRARIES}"
    )
endif()
