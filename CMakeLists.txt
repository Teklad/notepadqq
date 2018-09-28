cmake_minimum_required(VERSION 3.8.0)

# Set the project name
project(notepadqq LANGUAGES CXX VERSION 1.4.8)

# Add our cmake modules path
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake/Modules")

# Include any extra modules we want
include(BuildType)

# Make CMake work properly with QT
set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

# Import all the required packages
find_package(Qt5Core CONFIG REQUIRED)
find_package(Qt5Gui CONFIG REQUIRED)
find_package(Qt5LinguistTools CONFIG REQUIRED)
find_package(Qt5Network CONFIG REQUIRED)
find_package(Qt5PrintSupport CONFIG REQUIRED)
find_package(Qt5Svg CONFIG REQUIRED)
find_package(Qt5WebChannel CONFIG REQUIRED)
find_package(Qt5WebEngine CONFIG REQUIRED)
find_package(Qt5WebEngineWidgets CONFIG REQUIRED)
find_package(Qt5WebSockets CONFIG REQUIRED)
find_package(Qt5Widgets CONFIG REQUIRED)
find_package(UCharDet REQUIRED)

# Add subdirectories we want to build
add_subdirectory(src)

# Copy our launcher into the build directory for ease of use
configure_file(support_files/launch/notepadqq "${CMAKE_BINARY_DIR}/bin/notepadqq" COPYONLY)

# Install rules for support files
if (UNIX)
    include(GNUInstallDirs)
    install(FILES support_files/launch/notepadqq
        DESTINATION "${CMAKE_INSTALL_BINDIR}"
        PERMISSIONS OWNER_EXECUTE OWNER_WRITE OWNER_READ
                    GROUP_EXECUTE GROUP_READ
                    WORLD_EXECUTE WORLD_READ
    )
    install(DIRECTORY "support_files/icons" DESTINATION "${CMAKE_INSTALL_DATADIR}")
    install(FILES "support_files/shortcuts/notepadqq.desktop" DESTINATION "${CMAKE_INSTALL_DATADIR}/applications")
    install(FILES "support_files/notepadqq.appdata.xml" DESTINATION "${CMAKE_INSTALL_DATADIR}/metainfo")

    # Uninstall target
    if(NOT TARGET uninstall)
        configure_file(
            "${CMAKE_CURRENT_SOURCE_DIR}/cmake/cmake_uninstall.cmake.in"
            "${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake"
            IMMEDIATE @ONLY)

        add_custom_target(uninstall
            COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake)
    endif()
endif()

