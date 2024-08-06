#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface CharlieEngineInject : NSObject
@end

@implementation CharlieEngineInject

+ (void)initialize {
    // Hook into the application's lifecycle event
    [NSNotificationCenter.defaultCenter addObserver:self
                                         selector:@selector(applicationDidBecomeActive:)
                                             name:UIApplicationDidBecomeActiveNotification
                                           object:nil];
}

+ (void)applicationDidBecomeActive:(NSNotification *)notification {
    dispatch_async(dispatch_get_main_queue(), ^{
        // Ensure UI-related code runs on the main thread

        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Hello"
                                                                                  message:@"Yo!"
                                                                           preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Go away"
                                                            style:UIAlertActionStyleDefault
                                                          handler:nil];
        
        [alertController addAction:okAction];

        // Get the current key window
        UIWindow *keyWindow = [UIApplication.sharedApplication.windows firstObject];
        UIViewController *rootViewController = keyWindow.rootViewController;

        if (rootViewController && rootViewController.presentedViewController == nil) {
            [rootViewController presentViewController:alertController animated:YES completion:nil];
        } else {
            NSLog(@"Failed to present alert: rootViewController is nil or already presenting another view controller.");
        }
    });
}

@end
