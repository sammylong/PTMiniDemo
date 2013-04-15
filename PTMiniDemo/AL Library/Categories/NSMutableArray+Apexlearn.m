//
//  NSMutableArray+Apexlearn.m
//  PTMiniDemo
//
//  Created by Sammy Long on 13/4/15.
//  Copyright (c) 2013年 Apexlearn Inc. All rights reserved.
//

#import "NSMutableArray+Apexlearn.h"

@implementation NSMutableArray (Apexlearn)

- (void)shuffle {
    int max = [self count] - 1;
    while (max > 0) {
        int rand = arc4random_uniform(max);
        // swap array[max] and array[rand]
        [self exchangeObjectAtIndex:rand withObjectAtIndex:max];
        max--;
    }
}

@end
