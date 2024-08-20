#pragma once
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

namespace CharlieEngine {
    namespace log {
        NSString *log(NSString *str, NSString* logName) {
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];

            NSString* logPath = [documentsDirectory stringByAppendingPathComponent:logName];
            NSError *error = nil;

            NSString *wholeLog = [NSString stringWithContentsOfFile:logPath
                                                        encoding:NSUTF8StringEncoding
                                                        error:&error];
            NSString *newLog = [wholeLog stringByAppendingString:str];
            NSError* idk;
            BOOL success = [newLog writeToFile:logPath atomically:YES encoding:NSUTF8StringEncoding error:&idk];

            return str;
        }
    }
}