#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface CharlieEngineInject : NSObject
@end

@implementation CharlieEngineInject

+ (void)load {
    [self writeToLog:@"CharlieEngine Injection starting."];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class appDelegateClass = NSClassFromString(@"DDAppDelegate");
        if (appDelegateClass) {
            SEL originalSelector = @selector(applicationDidBecomeActive:);
            SEL swizzledSelector = @selector(charlie_applicationDidBecomeActive:);
            
            Method originalMethod = class_getInstanceMethod(appDelegateClass, originalSelector);
            Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
            
            BOOL didAddMethod = class_addMethod(appDelegateClass,
                                                originalSelector,
                                                method_getImplementation(swizzledMethod),
                                                method_getTypeEncoding(swizzledMethod));
            
            if (didAddMethod) {
                class_replaceMethod(appDelegateClass,
                                    swizzledSelector,
                                    method_getImplementation(originalMethod),
                                    method_getTypeEncoding(originalMethod));
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod);
            }
        } else {
            [self writeToLog:@"Failed to find DDAppDelegate class."];
        }
    });
}

+ (void)charlie_applicationDidBecomeActive:(UIApplication *)application {
    // Call the original implementation
    [self charlie_applicationDidBecomeActive:application];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // Ensure UI-related code runs on the main thread
        [self writeToLog:@"Presenting alert"];

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
