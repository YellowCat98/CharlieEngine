#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface CharlieEngineInject : NSObject
@end

@implementation CharlieEngineInject

+ (void)load {
    dispatch_async(dispatch_get_main_queue(), ^{
        // Ensure UI-related code runs on the main thread

        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Hello"
                                                                                  message:@"Yo!"
                                                                           preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Go away"
                                                            style:UIAlertActionStyleDefault
                                                          handler:nil];
        
        [alertController addAction:okAction];

        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        UIViewController *rootViewController = keyWindow.rootViewController;

        if (rootViewController.presentedViewController == nil) {
            [rootViewController presentViewController:alertController animated:YES completion:nil];
        }
    });
}

@end