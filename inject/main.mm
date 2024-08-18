#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#include <string>

//@interface CharlieEngineInject : NSObject
//@end

//@implementation CharlieEngineInject
//@end

__attribute__((constructor))
static void initialize() {
	NSString *str = @"hi";

	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"hi.txt"];

	NSError *error;
	BOOL success = [str writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
	if (!success) {
		NSLog(@"Error writing file: %@", [error localizedDescription]);
	}
}
