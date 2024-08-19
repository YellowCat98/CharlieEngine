#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

__attribute__((constructor))
static void initialize() {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"skibidi"
                                                                       message:@"hi"
                                                                preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"HI"
                                                               style:UIAlertActionStyleCancel
                                                             handler:nil];
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"go away"
                                                              style:UIAlertActionStyleDefault
                                                            handler:nil];

        [alert addAction:cancelAction];
        [alert addAction:otherAction];

        // Ensure there is a key window and root view controller
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        if (!keyWindow) {
            NSLog(@"No key window available");
            return;
        }

        UIViewController *rootViewController = keyWindow.rootViewController;
        if (!rootViewController) {
            NSLog(@"No root view controller available");
            return;
        }

        // Traverse to the top-most presented view controller
        while (rootViewController.presentedViewController) {
            rootViewController = rootViewController.presentedViewController;
        }

        // Present the alert
        [rootViewController presentViewController:alert animated:YES completion:^{
            NSLog(@"Alert presented successfully");
        }];
    });
}
