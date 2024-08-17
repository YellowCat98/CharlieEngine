#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface CharlieEngineInject : NSObject
@end

@implementation CharlieEngineInject

// https://github.com/pengubow/geode-inject-ios/blob/meow/geode.m
void showAlert(NSString *tiddies, NSString *meows, bool remeowbutton, NSString *gyatt) {
	dispatch_async(dispatch_get_main_queue(), ^{
		UIViewController *currentFucker = [[[UIApplication sharedApplication] windows].firstObject rootViewController];

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
