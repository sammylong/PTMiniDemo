//
//  StickerViewController.m
//  PTMiniDemo
//
//  Created by Sammy Long on 13/4/12.
//  Copyright (c) 2013年 Apexlearn Inc. All rights reserved.
//

#import "StickerViewController.h"
#import "StickerView.h"
#import "UIColor+ptmini.h"
#import "UIImage+ptmini.h"


static const int cNumberOfOption = 4;

@interface StickerViewController ()

@end

@implementation StickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    // placeHolder
    // TODO fix this magic number
    UIColor *strokeColor = [UIColor piGrayColor];
    UIColor *fillColor = [UIColor whiteColor];
    CGSize size = CGSizeMake(  [StickerView defaultWidth]
                             , [StickerView defaultHeight]);
    // TODO strokeColor
    UIImage *image = [UIImage piRoundedRectImageWithSize:size fillColor:fillColor cornerRadius:2.0f];

    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    CGPoint center = CGPointMake( CGRectGetMidX(self.itemDetailView.bounds), 60.0f);
    imageView.center = center;
    self.itemDetailView.placeHolder = imageView;
}

- (void)presentOptionViewsAnimated:(BOOL)animated {
    [super presentOptionViewsAnimated:animated];
    CGFloat offset = 20.0f;
    CGFloat availableHeight = CGRectGetMinY(self.itemDetailView.frame) - offset * 2.0f;
    CGFloat verticalSpacing = roundf(availableHeight/4.0f);
    CGFloat y = 20.0f;
    NSMutableArray *stickerViews = [NSMutableArray arrayWithCapacity:cNumberOfOption];
    for (int i=0; i<cNumberOfOption; i++) {
        // gen option view
        StickerView *stickerView = [[StickerView alloc] init];
        stickerView.delegate = self;
        stickerView.index = i;
        stickerView.text = [self.options objectAtIndex:i];
        stickerView.backgroundColor = [UIColor whiteColor];
        //CGFloat x = roundf(CGRectGetWidth(self.view.bounds) * 0.3f);
        //int randInt = - 15 + arc4random_uniform(30);
        //x += (CGFloat)randInt ;
        // TODO fix this magic number
        // so that when it is fully expanded, it appears in the middle
        CGFloat x = 80.0f;
        CGRect frame = stickerView.frame;
        frame.origin = CGPointMake(x, y);
        stickerView.frame = frame;
        // increment y for the next item
        y += verticalSpacing;// + (CGFloat)arc4random_uniform(10);

        [stickerView showInView:self.view animated:YES duration:0.2 delay:0.0 completion:nil];
        [stickerViews addObject:stickerView];
    }
    self.optionViews = stickerViews;
}


@end
