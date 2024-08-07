cmake_minimum_required(VERSION 3.14)
project(CharlieEngineInject VERSION 1.0 LANGUAGES OBJCXX CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Include CPM
include(cmake/CPM.cmake)

# Add packages using CPM
CPMAddPackage(
    NAME result
    GITHUB_REPOSITORY bitwizeshift/result
    GIT_TAG a97e66b
)

CPMAddPackage(
    NAME tuliphook
    GITHUB_REPOSITORY charlatano/tuliphook
    GIT_TAG main
)

# Add the include directories for tuliphook
include_directories(${tuliphook_SOURCE_DIR}/include)

# Add the library directories for tuliphook
link_directories(${tuliphook_SOURCE_DIR}/lib)

# Create the executable/library
add_library(CharlieEngineInject SHARED main.mm)

# Link the libraries
target_link_libraries(CharlieEngineInject PRIVATE tuliphook result)

# Additional include directories
target_include_directories(CharlieEngineInject PRIVATE ${result_SOURCE_DIR}/include)

# Set the install name for the library
set_target_properties(CharlieEngineInject PROPERTIES INSTALL_NAME_DIR "@rpath")

# Ensure the correct frameworks are linked
find_library(UIKIT_FRAMEWORK UIKit REQUIRED)
find_library(FOUNDATION_FRAMEWORK Foundation REQUIRED)
target_link_libraries(CharlieEngineInject PRIVATE ${UIKIT_FRAMEWORK} ${FOUNDATION_FRAMEWORK})

# Ensure the output directories are correctly set
set_target_properties(CharlieEngineInject PROPERTIES
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/Release-iphoneos
    ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/Release-iphoneos
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/Release-iphoneos
)
