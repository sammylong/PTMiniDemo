//
//  LineLayout.m
//  PTMiniDemo
//
//  Created by Sammy Long on 13/4/10.
//  Copyright (c) 2013年 Apexlearn Inc. All rights reserved.
//

#import "LineLayout.h"


@implementation LineLayout

- (id)init {
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(176.0f, 214.0f);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.minimumLineSpacing = 34.0f;
    }
    return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds
{
    return YES;
}


@end
