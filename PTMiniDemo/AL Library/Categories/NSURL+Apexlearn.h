//
//  NSURL+Apexlearn.h
//  ParrotTalks
//
//  Created by Sammy Long on 12/12/26.
//  Copyright (c) 2012年 Apexlearn Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (Apexlearn)

- (NSURL *)URLByAppendingQueryString:(NSString *)queryString;
- (BOOL)addSkipBackupAttribute;

@end
