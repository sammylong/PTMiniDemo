//
//  NSURL+Apexlearn.m
//  ParrotTalks
//
//  Created by Sammy Long on 12/12/26.
//  Copyright (c) 2012年 Apexlearn Inc. All rights reserved.
//

#import "NSURL+Apexlearn.h"

@implementation NSURL (Apexlearn)

- (NSURL *)URLByAppendingQueryString:(NSString *)queryString {
    //http://stackoverflow.com/questions/6309698/objective-c-how-to-add-query-parameter-to-nsurl
    if (![queryString length]) {
        return self;
    }
    NSString *URLString = [[NSString alloc] initWithFormat:@"%@%@%@",
                           [self absoluteString],
                           @"?",
                           queryString];
    NSURL *theURL = [NSURL URLWithString:URLString];
    return theURL;
}

- (BOOL)addSkipBackupAttribute {
    assert([[NSFileManager defaultManager] fileExistsAtPath: [self path]]);
    
    NSError *error = nil;
    BOOL success = [self setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
        NSLog(@"Error excluding %@ from backup %@", [self lastPathComponent], error);
    }
    return success;
}

@end
