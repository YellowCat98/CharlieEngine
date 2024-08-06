cmake_minimum_required(VERSION 3.14)
project(CharlieEngineInject VERSION 1.0 LANGUAGES OBJCXX)

# Define the source files
set(SOURCES
    main.mm
    main.hpp
)

# Create the dynamic library
add_library(CharlieEngineInject SHARED ${SOURCES})

# Set target properties for iOS
set_target_properties(CharlieEngineInject PROPERTIES
    FRAMEWORK FALSE
    PLATFORM "iOS"
    XCODE_ATTRIBUTE_CODE_SIGNING_REQUIRED "NO"
    XCODE_ATTRIBUTE_CODE_SIGNING_ALLOWED "NO"
    OUTPUT_NAME "CharlieEngineInject"  # Set the output name for the dylib
)

# Specify the output directory
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/output)

# Ensure CMake knows we're targeting iOS
if(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
    set(CMAKE_OSX_SYSROOT /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk)
    set(CMAKE_OSX_ARCHITECTURES arm64)
    set(CMAKE_OSX_DEPLOYMENT_TARGET "16.0")  # Set the minimum iOS version
endif()
