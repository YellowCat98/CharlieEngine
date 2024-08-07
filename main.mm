#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface CharlieEngineInject : NSObject
+ (void)initializeInjection;
@end

@implementation CharlieEngineInject

+ (void)initializeInjection {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleAppDelegate];
    });
}

+ (void)swizzleAppDelegate {
    Class appDelegateClass = NSClassFromString(@"DDAppDelegate");
    if (appDelegateClass) {
        SEL originalSelector = @selector(initialize);
        SEL swizzledSelector = @selector(charlie_initialize);

        Method originalMethod = class_getClassMethod(appDelegateClass, originalSelector);
        Method swizzledMethod = class_getClassMethod(self, swizzledSelector);

        if (originalMethod && swizzledMethod) {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        } else {
            [self writeToLog:@"Failed to find original or swizzled method on DDAppDelegate."];
        }
    } else {
        [self writeToLog:@"Failed to find DDAppDelegate class."];
    }
}

+ (void)charlie_initialize {
    // Call the original implementation
    [self charlie_initialize];

    // Perform your custom actions here
    dispatch_async(dispatch_get_main_queue(), ^{
        [self writeToLog:@"Performing post-initialization tasks"];

        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Hello"
                                                                                  message:@"Yo!"
                                                                           preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Go away"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];

        [alertController addAction:okAction];

        UIWindow *keyWindow = [UIApplication.sharedApplication.windows firstObject];
        UIViewController *rootViewController = keyWindow.rootViewController;

        if (rootViewController && rootViewController.presentedViewController == nil) {
            [rootViewController presentViewController:alertController animated:YES completion:nil];
        } else {
            [self writeToLog:@"Failed to present alert: rootViewController is nil or already presenting another view controller."];
        }
    });
}

+ (void)writeToLog:(NSString *)message {
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *logFilePath = [documentsPath stringByAppendingPathComponent:@"CharlieEngineInject.log"];

    NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:logFilePath];
    if (!fileHandle) {
        [[NSFileManager defaultManager] createFileAtPath:logFilePath contents:nil attributes:nil];
        fileHandle = [NSFileHandle fileHandleForWritingAtPath:logFilePath];
    }

    [fileHandle seekToEndOfFile];
    NSString *logMessage = [NSString stringWithFormat:@"%@\n", message];
    [fileHandle writeData:[logMessage dataUsingEncoding:NSUTF8StringEncoding]];
    [fileHandle closeFile];
}

@end
