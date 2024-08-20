#pragma once
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <errno.h>

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
    bool hasJIT(int pid) {
        int flags = 0;

        while (true) {
            int ret = csops(pid, 0x00000000, &flags, sizeof(flags));
            if (ret != 0) {
                perror("csops failed");
                return false;
            }

            bool actuallyhasJIT = (flags & 0x10000000) != 0;

            if (actuallyhasJIT) {
                return true;  // JIT is enabled, exit the loop and return true
            }

            sleep(1);  // Wait for 1 second before checking again
        }
    }

}