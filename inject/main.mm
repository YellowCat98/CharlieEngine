#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#include <string>
#include <dlfcn.h>

__attribute__((constructor))
static void initialize() {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];

	NSString* dylibPath = [documentsDirectory stringByAppendingPathComponent:@"libCharlieEngineLoader.dylib"];

	if ([[NSFileManager defaultManager] fileExistsAtPath:dylibPath]) {
		void *handle = dlopen([dylibPath UTF8String], RTLD_LAZY); // what does that last arg do
		if (!handle) {
			NSLog(@"Error loading libCharlieEngineLoader.dylib: %s", dlerror());
			NSString* errorPath = [documentsDirectory stringByAppendingPathComponent:@"last_err.txt"];
			NSError* error;
			//NSString* errorString = dlerror();
			NSString* errorString = [NSString stringWithFormat:@"Error loading libCharlieEngineLoader.dylib: %s", dlerror()];
			BOOL success = [errorString writeToFile:errorPath atomically:YES encoding:NSUTF8StringEncoding error:&error];
			if (!success) {
				NSLog(@"Error writing Error.");
			}
		}
	} else {
			NSString *str = @"PLACE libCharlieEngineLoader.dylib HERE";

			NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"PLACE libCharlieEngineLoader.dylib HERE"];

			NSError *error;
			BOOL success = [str writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
			if (!success) {
				NSLog(@"Error writing file: %@", [error localizedDescription]);
			}
    }
}
