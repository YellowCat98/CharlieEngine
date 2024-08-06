// HelloWorldDylib.m
#import "main.hpp"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@implementation CharlieEngineInject : NSObject

+ (void)load {
    [self loadLibrary];
}

+ (void)loadLibrary {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Hello"
                                                                   message:@"Hello, World!"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK"
                                                 style:UIAlertActionStyleDefault
                                               handler:nil];
    [alert addAction:ok];

    // Get the key window's root view controller and present the alert
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        UIViewController *rootViewController = keyWindow.rootViewController;
        [rootViewController presentViewController:alert animated:YES completion:nil];
    });
}

@end
