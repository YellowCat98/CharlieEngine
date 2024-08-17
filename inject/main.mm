#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface CharlieEngineInject : NSObject
@end

@implementation CharlieEngineInject
@end

__attribute__((constructor))
static void initialize() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"Hello from CharlieEngine");
    });
}
