#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#include "utils.hpp"

using namespace CharlieEngine;

__attribute__((constructor))
static void initialize() {
    utils::log("Hello!", "CharlieEngineLoader.log");
}
