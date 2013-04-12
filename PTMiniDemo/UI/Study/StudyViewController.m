//
//  StudyViewController.m
//  PTMiniDemo
//
//  Created by Sammy Long on 13/4/11.
//  Copyright (c) 2013年 Apexlearn Inc. All rights reserved.
//

#import "StudyViewController.h"
#import "Catalog.h"
#import "UIColor+ptmini.h"
#import "Item.h"


static const NSTimeInterval cCuedTime = 2.0;
static const CGFloat cItemDetailViewRelativePositionOnDock = 0.5;
static const CGFloat cItemDetailViewAnimationDuration = 0.25;
static const int cNumberOfOption = 4;


@interface StudyViewController () <ItemDetailViewDelegate> {
    Catalog *_catalog;
}
@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation StudyViewController

- (id)initWithCatalog:(Catalog *)catalog {
    self = [super init];
    if (self) {
        _catalog = catalog;
        NSArray *items = [catalog.items allObjects];
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastStudiedDate" ascending:NO];
        self.items = [[items sortedArrayUsingDescriptors:@[sortDescriptor]] mutableCopy];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor piLightBlueColor];
    // scrollview
    self.itemDetailView = [[ItemDetailView alloc] initWithFrame:self.view.bounds];
    self.itemDetailView.delegate = self;
    CGRect frame = self.itemDetailView.frame;
    frame.origin.y = roundf(CGRectGetHeight(self.view.bounds) * cItemDetailViewRelativePositionOnDock);
    self.itemDetailView.frame = frame;
    [self.view addSubview:self.itemDetailView];
    // add a cancel button
    // TODO cross
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [cancelButton addTarget:self action:@selector(invokeCancelBlock) forControlEvents:UIControlEventTouchUpInside];
    frame = cancelButton.frame;
    frame.origin = CGPointMake(20.0f, 20.0f);
    cancelButton.frame = frame;
    [self.view addSubview:cancelButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // present
    [self presentNextItemAnimated:NO];
}

- (void)presentNextItemAnimated:(BOOL)animated {
    if ([self.items count] > 0) {
        // remove old answer view
        // TODO
        [self.itemDetailView.answerView removeFromSuperview];
        // get an object from items
        Item *item = [self.items lastObject];
        [self.items removeObject:item];
        [self.itemDetailView setImage: [UIImage imageNamed:item.imageName]
                             animated: animated];
        self.mode = eStudyViewModeCueing;
        // schedule display of options
        StudyViewController *weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, cCuedTime * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [weakSelf presentOptionViewsAnimated:YES];
        });
    }
}

- (void)presentOptionViewsAnimated:(BOOL)animated {
    // child class implement
    self.mode = eStudyViewModeRecall;
}

- (void)openItemDetailViewAnimated:(BOOL)animated {
    if (animated) {
        NSTimeInterval duration = cItemDetailViewAnimationDuration;
        //CGAffineTransform translationTransform = CGAffineTransformMakeTranslation(CGRectGetHeight(self.view.bounds) * cItemDetailViewRelativePositionOnDock, 0.0f);
        [UIView animateWithDuration:duration
                         animations:^{
                             CGRect frame = self.itemDetailView.frame;
                             frame.origin.y = 20.0f;
                             self.itemDetailView.frame = frame;
                         }
                         completion:nil];
    } else {
        CGRect frame = self.itemDetailView.frame;
        frame.origin.y = 0.0f;
        self.itemDetailView.frame = frame;
    }
}

- (void)dockItemDetailViewAnimated:(BOOL)animated {
    if (animated) {
        NSTimeInterval duration = cItemDetailViewAnimationDuration;
        [UIView animateWithDuration:duration
                         animations:^{
                             CGRect frame = self.itemDetailView.frame;
                             frame.origin.y = CGRectGetHeight(self.view.bounds) * cItemDetailViewRelativePositionOnDock;
                             self.itemDetailView.frame = frame;
                         }
                         completion:nil];
    } else {
        CGRect frame = self.itemDetailView.frame;
        frame.origin.y = CGRectGetHeight(self.view.bounds) * cItemDetailViewRelativePositionOnDock;
        self.itemDetailView.frame = frame;
    }
}


#pragma mark ItemDetailViewDelegate

- (void)itemDetailViewSwipedUp:(ItemDetailView *)detailView {
    // animate detail view
    NSLog(@"%s", __PRETTY_FUNCTION__);
    if (self.mode == eStudyViewModeRecalled) {
        [self openItemDetailViewAnimated:YES];
    }
}

- (void)itemDetailViewSwipedDown:(ItemDetailView *)detailView {
    // animate detail view
    NSLog(@"%s", __PRETTY_FUNCTION__);
    if (self.mode == eStudyViewModeRecalled) {
        [self dockItemDetailViewAnimated:YES];
    }
}


#pragma mark OptionViewDelegate

- (void)optionViewBeganDragging:(OptionView *)optionView {
    [self.view bringSubviewToFront:optionView];
}

- (void)optionViewEndDragging:(OptionView *)optionView {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    // detect if this view is ..
    if (CGRectIntersectsRect(optionView.frame, self.itemDetailView.frame)) {
        NSLog(@"dragged and dropped option view");
        self.mode = eStudyViewModeRecalled;
        // TODO lock and dismiss all other option view
        for (OptionView *optionView in self.optionViews) {
            optionView.locked = YES;
        }
        NSMutableArray *optionViewsExcludedSelected = [NSMutableArray arrayWithArray:self.optionViews];
        [optionViewsExcludedSelected removeObject:optionView];
        for (OptionView *optionView in optionViewsExcludedSelected) {
            [optionView dismiss:YES duration:0.2 delay:0.0 completionBlock:nil];
        }
        // move option view to item detail view
        CGRect frame = optionView.frame;
        frame.origin.y -= CGRectGetMinY(self.itemDetailView.frame);
        optionView.frame = frame;
        [self.itemDetailView addSubview:optionView];
        self.itemDetailView.answerView = optionView;
        [self didSelectOptionWithIndex:optionView.index];
    }
}

- (void)didSelectOptionWithIndex:(int)index {
    // correct
    BOOL correct = YES;
    if (correct) {
        // bounce the sticker
        StudyViewController *weakSelf = self;
        [self.itemDetailView bounceCircleWithCompletion:^{
            // present new item later
            // dispatch after
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [weakSelf presentNextItemAnimated:YES];
            });
        }];
    } else {
        // vibrate and slide out the item detail view
        StudyViewController *weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.4 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [weakSelf openItemDetailViewAnimated:YES];
        });
    }
}

@end
