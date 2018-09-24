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

# First we load up pkg-config for 3rd party libraries
find_package(PkgConfig REQUIRED)

# Import all the required QT packages
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

# Check for 3rd party libraries that don't have find_package
pkg_check_modules(UCharDet REQUIRED uchardet)

# Add subdirectories we want to build
add_subdirectory(src)

# Copy necessary files into build directory
configure_file(support_files/launch/notepadqq "${CMAKE_BINARY_DIR}/bin/notepadqq" COPYONLY)
