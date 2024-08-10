#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface CharlieEngineInject : NSObject
+ (void)initializeInjection;
@end

@implementation CharlieEngineInject

+ (void)initializeInjection {
    dispatch_async(dispatch_get_main_queue(), ^{
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

__attribute__((constructor))
static void initialize() {
    [self writeToLog:@"CharlieEngine Injected!"]
    [CharlieEngineInject initializeInjection];
}
