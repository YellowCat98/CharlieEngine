#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#include <string>

@interface CharlieEngineInject : NSObject
@end

@implementation CharlieEngineInject

void showAlert(NSString *tiddies, NSString *meows, NSString *gyatt) {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        if (!keyWindow) {
            NSLog(@"Error: keyWindow is nil");
            return;
        }
        
        UIViewController *currentFucker = keyWindow.rootViewController;
        if (!currentFucker) {
            NSLog(@"Error: rootViewController is nil");
            return;
        }

        while (currentFucker.presentedViewController) {
            currentFucker = currentFucker.presentedViewController;
        }

        UIAlertController *alert = [UIAlertController alertControllerWithTitle:tiddies message:meows preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *fuckoff = [UIAlertAction actionWithTitle:gyatt style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:fuckoff];

        [currentFucker presentViewController:alert animated:YES completion:nil];
    });
}

// Function to write data to a file in the Documents directory
void writeFileToDocumentsDirectory(const std::string& fileName, const std::string& content) {
    // Convert std::string to NSString
    NSString *fileNameNSString = [NSString stringWithUTF8String:fileName.c_str()];
    NSString *contentNSString = [NSString stringWithUTF8String:content.c_str()];

    // Get the path to the Documents directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    // Create the full file path
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileNameNSString];
    
    // Write the content to the file
    NSError *error = nil;
    BOOL success = [contentNSString writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    if (!success) {
        NSLog(@"Failed to write file: %@", [error localizedDescription]);
    } else {
        NSLog(@"File successfully written to %@", filePath);
    }
}


@end

__attribute__((constructor))
static void initialize() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        writeFileToDocumentsDirectory("test.txt", "HI");
    });
}
