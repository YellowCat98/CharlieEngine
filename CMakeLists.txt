cmake_minimum_required(VERSION 3.14)
project(CharlieEngineInject VERSION 1.0 LANGUAGES OBJCXX CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Include CPM
include(cmake/CPM.cmake)


# Define the source files
set(INJECT_SOURCES
    inject/main.mm
)

# Create the dynamic library
add_library(CharlieEngineInject SHARED ${INJECT_SOURCES})

# Set target properties for iOS
set_target_properties(CharlieEngineInject PROPERTIES
    FRAMEWORK FALSE
    PLATFORM "iOS"
    XCODE_ATTRIBUTE_CODE_SIGNING_REQUIRED "NO"
    XCODE_ATTRIBUTE_CODE_SIGNING_ALLOWED "NO"
    OUTPUT_NAME "CharlieEngineInject"  # Set the output name for the dylib
)

# Ensure CMake knows we're targeting iOS
if(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
    set(CMAKE_OSX_SYSROOT /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk)
    set(CMAKE_OSX_ARCHITECTURES arm64)
    set(CMAKE_OSX_DEPLOYMENT_TARGET "16.0")  # Set the minimum iOS version

    # Add necessary frameworks for iOS
    target_link_libraries(CharlieEngineInject
        "-framework UIKit"
        "-framework Foundation"
    )
endif()
