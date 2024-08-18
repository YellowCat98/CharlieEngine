#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#include <string>

@interface CharlieEngineInject : NSObject
@end

@implementation CharlieEngineInject
@end

__attribute__((constructor))
static void initialize() {
    //dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		NSString *str = @"hi";

		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentsDirectory = [paths objectAtIndex:0];
		NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"hi.txt"];

		NSError *error;
		BOOL success = [str writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
		if (!success) {
			NSLog(@"Error writing file: %@", [error localizedDescription]);
		}
   // });
}
