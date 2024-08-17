#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@interface CharlieEngineLoader : NSObject
@end

@implementation CharlieEngineLoader
@end

// Initialize function that is called when the shared library or executable is loaded
__attribute__((constructor))
static void initialize() {
    
}
