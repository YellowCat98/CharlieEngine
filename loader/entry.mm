#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

// Declare the logging function
bool logToCTSLog(const std::string& message);

@interface CharlieEngineLoader : NSObject
@end

@implementation CharlieEngineLoader
@end

// Define the logging function
bool logToCTSLog(const std::string& message) {
    // Convert std::string to NSString
    NSString* nsMessage = [NSString stringWithUTF8String:message.c_str()];

    // Get the path to the Documents directory
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];

    // Create the full path for the log file
    NSString* logFilePath = [documentsDirectory stringByAppendingPathComponent:@"cts.log"];

    // Append the message to the log file
    NSFileHandle* fileHandle = [NSFileHandle fileHandleForWritingAtPath:logFilePath];
    if (!fileHandle) {
        // If the file doesn't exist, create it
        [[NSFileManager defaultManager] createFileAtPath:logFilePath contents:nil attributes:nil];
        fileHandle = [NSFileHandle fileHandleForWritingAtPath:logFilePath];
    }

    // Move the file pointer to the end of the file
    [fileHandle seekToEndOfFile];

    // Convert NSString to NSData
    NSData* data = [nsMessage dataUsingEncoding:NSUTF8StringEncoding];
    
    // Write the data to the file
    [fileHandle writeData:data];
    [fileHandle writeData:[@"\n" dataUsingEncoding:NSUTF8StringEncoding]]; // Add a newline

    // Close the file handle
    [fileHandle closeFile];

    return YES;
}

// Initialize function that is called when the shared library or executable is loaded
__attribute__((constructor))
static void initialize() {
    logToCTSLog("CharlieEngineLoader initialized.");
}
