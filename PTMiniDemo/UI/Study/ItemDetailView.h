//
//  ItemDetailView.h
//  PTMiniDemo
//
//  Created by Sammy Long on 13/4/11.
//  Copyright (c) 2013年 Apexlearn Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ItemDetailViewDelegate;
@class OptionView;

@interface ItemDetailView : UIView

@property (nonatomic, weak) id<ItemDetailViewDelegate> delegate;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *audioName;
@property (nonatomic, strong) UIView *placeHolder;
@property (nonatomic, strong) OptionView *answerView;

- (void)setImage:(UIImage *)image animated:(BOOL)animated;
- (void)play;
- (void)bounceCircleWithCompletion:(ALCompletionBlock)completionBlock;

@end

@protocol ItemDetailViewDelegate <NSObject>

- (void)itemDetailViewSwipedUp:(ItemDetailView *)detailView;
- (void)itemDetailViewSwipedDown:(ItemDetailView *)detailView;
- (void)itemDetailViewDidFinishPlaying:(ItemDetailView *)detailView;
@end