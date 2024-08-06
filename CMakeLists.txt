cmake_minimum_required(VERSION 3.14)
project(CharlieEngineInject VERSION 1.0 LANGUAGES OBJC)

# Define the source files
set(SOURCES
    main.m
    main.h
)

# Create the dynamic library
add_library(${PROJECT_NAME} SHARED ${SOURCES})

# Set target properties for iOS
set_target_properties(${PROJECT_NAME} PROPERTIES
    FRAMEWORK TRUE
    PLATFORM "iOS"
)

# Specify the output directory
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/output)
