//
//  StudyViewController.h
//  PTMiniDemo
//
//  Created by Sammy Long on 13/4/11.
//  Copyright (c) 2013年 Apexlearn Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OptionView.h"
#import "ItemDetailView.h"


typedef enum {
      eStudyViewModeCueing
    , eStudyViewModeRecall
    , eStudyViewModeRecalled
} eStudyViewMode;

@class Catalog;
@class Item;

@interface StudyViewController : UIViewController <OptionViewDelegate>

@property (nonatomic) eStudyViewMode mode;
@property (nonatomic, strong) ItemDetailView *itemDetailView;
@property (nonatomic, strong) Item *item;
@property (nonatomic, strong) NSArray *options;
@property (nonatomic, strong) NSArray *optionViews;
@property (nonatomic) BOOL presentOptionsAfterPlayingAudio;
@property (nonatomic) NSTimeInterval cuedTime;

- (id)initWithCatalog:(Catalog *)catalog;
- (void)presentNextItemAnimated:(BOOL)animated;
- (void)presentOptionViewsAnimated:(BOOL)animated;
- (void)openItemDetailViewAnimated:(BOOL)animated;
- (void)dockItemDetailViewAnimated:(BOOL)animated;

- (void)didSelectOptionWithIndex:(int)index;
@end
