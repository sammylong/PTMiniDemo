//
//  NSString+Apexlearn.m
//  ParrotTalks
//
//  Created by Sammy Long on 12/10/15.
//  Copyright (c) 2012年 Apexlearn Inc. All rights reserved.
//

#import "NSString+Apexlearn.h"

@implementation NSString (Apexlearn)

- (NSString *)apexURLEncode {
    return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (BOOL)apexIsValidEmailAddress {
    NSError *error = NULL;
    static NSString *emailValidationPattern = @"^((\"[\\w-+\\s]+\")|([\\w-+]+(?:\\.[\\w-+]+)*)|(\"[\\w-+\\s]+\")([\\w-+]+(?:\\.[\\w-+]+)*))(@((?:[\\w-+]+\\.)*\\w[\\w-+]{0,66})\\.([a-z]{2,6}(?:\\.[a-z]{2})?)$)|(@\\[?((25[0-5]\\.|2[0-4][\\d]\\.|1[\\d]{2}\\.|[\\d]{1,2}\\.))((25[0-5]|2[0-4][\\d]|1[\\d]{2}|[\\d]{1,2})\\.){2}(25[0-5]|2[0-4][\\d]|1[\\d]{2}|[\\d]{1,2})\\]?$)";
    NSRegularExpression *emailRegex = [NSRegularExpression regularExpressionWithPattern:emailValidationPattern
                                                                                options:NSRegularExpressionCaseInsensitive
                                                                                  error:&error
                                       ];
    NSUInteger numberOfMatches = [emailRegex numberOfMatchesInString:self options:0 range:NSMakeRange(0, [self length])];
    return numberOfMatches == 1;
}

@end
