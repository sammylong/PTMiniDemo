//
//  ALLog.m
//  ParrotTalks
//
//  Created by Sammy Long on 13/3/25.
//  Copyright (c) 2013年 Apexlearn Inc. All rights reserved.
//

#import "ALLog.h"


void(^sALLogHelperBlock)(const char *filepath, int line, NSString *message) = nil;


void ALLogHelper(const char *filepath, int line, NSString *message) {
    NSString *fixedLengthFilename = [[[NSString stringWithUTF8String:filepath] lastPathComponent] stringByPaddingToLength:30
                                                                                                               withString:@" "
                                                                                                          startingAtIndex:0];
    NSLog(@"%@ %4d:  %@", fixedLengthFilename, line, message);
    if (sALLogHelperBlock) {
        sALLogHelperBlock(filepath, line, message);
    }
}

void ALLogSetBlock(void(^block)(const char *filepath, int line, NSString *message)) {
    sALLogHelperBlock = [block copy];
}
