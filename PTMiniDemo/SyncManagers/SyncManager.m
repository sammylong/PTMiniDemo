//
//  SyncManager.m
//  PTMiniDemo
//
//  Created by Sammy Long on 13/4/10.
//  Copyright (c) 2013年 Apexlearn Inc. All rights reserved.
//

#import "SyncManager.h"


@implementation SyncManager

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
