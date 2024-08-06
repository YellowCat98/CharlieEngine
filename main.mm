#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <obj/runtime.h>

@implementation CharlieEngineInject : NSObject

+ (void)load {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"hello"
                                                                              message:@"yo!"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
      
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"go away"
                                                      style:UIAlertActionStyleDefault
                                                    handler:nil];
      
    [alertController addAction:okAction];

    UIViewController *rootViewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];

    [rootViewController presentViewController:alertController animated:YES completion:nil];
}

+ (void)loadLibrary {
      
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"hello"
                                                                              message:@"yo!"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
      
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"go away"
                                                      style:UIAlertActionStyleDefault
                                                    handler:nil];
      
    [alertController addAction:okAction];

    UIViewController *rootViewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];

    [rootViewController presentViewController:alertController animated:YES completion:nil];
  }

@end
