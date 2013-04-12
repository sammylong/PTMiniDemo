//
//  StickerViewController.m
//  PTMiniDemo
//
//  Created by Sammy Long on 13/4/12.
//  Copyright (c) 2013年 Apexlearn Inc. All rights reserved.
//

#import "StickerViewController.h"
#import "StickerView.h"


static const int cNumberOfOption = 4;

@interface StickerViewController ()

@end

@implementation StickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)presentOptionViewsAnimated:(BOOL)animated {
    [super presentOptionViewsAnimated:animated];
    CGFloat offset = 20.0f;
    CGFloat availableHeight = CGRectGetMinY(self.itemDetailView.frame) - offset * 2.0f;
    CGFloat verticalSpacing = roundf(availableHeight/4.0f);
    CGSize size = CGSizeMake(20.0f, 40.0f);
    CGFloat y = - roundf(size.height / 2.0f);
    NSMutableArray *stickerViews = [NSMutableArray arrayWithCapacity:cNumberOfOption];
    for (int i=0; i<cNumberOfOption; i++) {
        // gen option view
        StickerView *stickerView = [[StickerView alloc] initWithFrame:CGRectMake( 0.0f
                                                                                 ,0.0f
                                                                                 ,size.width
                                                                                 ,size.height)];
        stickerView.delegate = self;
        stickerView.index = i;
        stickerView.backgroundColor = [UIColor whiteColor];
        CGFloat x = roundf(CGRectGetWidth(self.view.bounds) * 0.3f);
        int randInt = - 15 + arc4random_uniform(30);
        x += (CGFloat)randInt ;
        y += verticalSpacing + (CGFloat)arc4random_uniform(10);
        stickerView.center = CGPointMake(x, y);
        [stickerView showInView:self.view animated:YES duration:0.2 delay:0.0 completion:nil];
        [stickerViews addObject:stickerView];
    }
    self.optionViews = stickerViews;
}


@end
