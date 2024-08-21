#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#include <string>
#include <dlfcn.h>
#include "utils.hpp"
#include "bypass_dyld_validation.hpp"

int csops(pid_t pid, unsigned int ops, void *useraddr, size_t usersize);

void downloadLoader(NSString* urlString, NSString* outputPath) {
	NSURL *url = [NSURL URLWithString:urlString];
	NSURLSession *session = [NSURLSession sharedSession];

	NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
		if (error) {
			NSLog(@"Download failed: %@", [error localizedDescription]);
			return;
		}

		NSFileManager *fileManager = [NSFileManager defaultManager];
		NSURL *destinationURL = [NSURL fileURLWithPath:outputPath];

		NSError *fileError;
		[fileManager moveItemAtURL:location toURL:destinationURL error:&fileError];
		if (fileError) {
			NSString *error = [fileError localizedDescription];
			CharlieEngine::utils::log(error, @"log.txt");
			
		} else {
			NSLog(@"File downloaded successfully to: %@", outputPath);
		}
	}];

	[downloadTask resume];
}

__attribute__((constructor))
static void initialize() {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];

	NSString* dylibPath = [documentsDirectory stringByAppendingPathComponent:@"libCharlieEngineLoader.dylib"];

	if ([[NSFileManager defaultManager] fileExistsAtPath:dylibPath]) {
		bool hasJIT = CharlieEngine::utils::hasJIT([[NSProcessInfo processInfo] processIdentifier]);
		if (hasJIT) {
			CharlieEngine::dyldBypass::init_bypassDyldLibValidation();
			void *handle = dlopen([dylibPath UTF8String], RTLD_NOW); // ok now i know what that last one do!!!
			if (!handle) {
				NSLog(@"Error loading libCharlieEngineLoader.dylib: %s", dlerror());
				NSString* errorPath = [documentsDirectory stringByAppendingPathComponent:@"last_err.txt"];
				NSError* error;

				NSString* errorString = [NSString stringWithFormat:@"Error loading libCharlieEngineLoader.dylib: %s", dlerror()];
				BOOL success = [errorString writeToFile:errorPath atomically:YES encoding:NSUTF8StringEncoding error:&error];
				if (!success) {
					NSLog(@"Error writing Error.");
				}
			}
		}

	} else {
			CharlieEngine::utils::log("Hello!", "CharlieEngineInject.log");
			downloadLoader(@"https://github.com/YellowCat98/CharlieEngine/releases/download/nightly/libCharlieEngineLoader.dylib", dylibPath);
			//NSString *str = @"PLACE libCharlieEngineLoader.dylib HERE";

			//NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"PLACE libCharlieEngineLoader.dylib HERE"];

			//NSError *error;
			//BOOL success = [str writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
			//if (!success) {
			//	NSLog(@"Error writing file: %@", [error localizedDescription]);
			//}
    }
}
