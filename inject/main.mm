#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface CharlieEngineInject : NSObject
@end

@implementation CharlieEngineInject

void showAlert(NSString *tiddies, NSString *meows, bool remeowbutton, NSString *gyatt) {
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

@end

__attribute__((constructor))
static void initialize() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        showAlert(@"hi", @"charlie gyatt a gyat!", false, @"ok");
    });
}
