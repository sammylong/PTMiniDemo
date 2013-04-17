//
//  BubbleViewController.m
//  PTMiniDemo
//
//  Created by Sammy Long on 13/4/17.
//  Copyright (c) 2013年 Apexlearn Inc. All rights reserved.
//

#import "BubbleViewController.h"
#import "BubbleView.h"
#import "UIColor+ptmini.h"
#import "UIImage+ptmini.h"

static const int cNumberOfOption = 4;

@interface BubbleViewController ()

@end

@implementation BubbleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGFloat size = roundf([BubbleView defaultWidth]/2.0f);
    UIColor *strokeColor = [UIColor piGrayColor];
    UIColor *fillColor = [UIColor whiteColor];
    UIImage *image = [UIImage piStretchableRoundedRectImageWithCornerRadius:size lineWidth:2.0f strokeColor:strokeColor fillColor:fillColor];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    CGPoint center = CGPointMake( CGRectGetMidX(self.itemDetailView.bounds), 80.0f);
    imageView.center = center;
    self.itemDetailView.placeHolder = imageView;
}

- (void)presentOptionViewsAnimated:(BOOL)animated {
    [super presentOptionViewsAnimated:animated];
    // place bubbles
    CGFloat horizontalSpacing = roundf(CGRectGetWidth(self.view.bounds) / cNumberOfOption);
    CGFloat x = roundf(horizontalSpacing/2.0f);
    NSMutableArray *bubbleViews = [NSMutableArray arrayWithCapacity:cNumberOfOption];
    UIColor *color = [UIColor piGreenColor];
    for (int i=0; i<cNumberOfOption; i++) {
        BubbleView *bubbleView = [[BubbleView alloc] initWithColor:color];
        bubbleView.delegate = self;
        bubbleView.index = i;
        bubbleView.text = [self.options objectAtIndex:i];
        int randInt = - 30 + arc4random_uniform(60);
        CGFloat y = 120.0f + (CGFloat)randInt;
        bubbleView.center = CGPointMake(x, y);
        [bubbleView showInView:self.view animated:YES duration:0.2 delay:0.0 completion:nil];
        [bubbleViews addObject:bubbleView];
        x+= horizontalSpacing;
    }
    self.optionViews = bubbleViews;
}

@end
