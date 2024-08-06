cmake_minimum_required(VERSION 3.14)
project(CharlieEngineInject VERSION 1.0 LANGUAGES OBJC)

# Set the C++ standard (if needed)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Define the source files
set(SOURCES
    main.m
    main.h
)

# Create the dynamic library
add_library(CharlieEngineInject SHARED ${SOURCES})

# Specify the target properties for iOS
set_target_properties(CharlieEngineInject PROPERTIES
    PLATFORM "iOS"
    XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "iPhone Developer"
)

# Specify the output directory
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/output)
