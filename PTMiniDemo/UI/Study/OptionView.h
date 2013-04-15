//
//  OptionView.h
//  PTMiniDemo
//
//  Created by Sammy Long on 13/4/12.
//  Copyright (c) 2013年 Apexlearn Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OptionViewDelegate;

@interface OptionView : UIView

@property (nonatomic, weak)id<OptionViewDelegate> delegate;
@property (nonatomic) NSInteger index;
@property (nonatomic, strong) NSString *text;
@property (nonatomic) BOOL locked;

- (void)showInView:(UIView *)view
          animated:(BOOL)animated
          duration:(NSTimeInterval)duration
             delay:(NSTimeInterval)delay
        completion:(ALCompletionBlock)completionBlock;
- (void)dismiss:(BOOL)animated
       duration:(NSTimeInterval)duration
          delay:(NSTimeInterval)delay
completionBlock:(ALCompletionBlock)completionBlock;

@end

@protocol OptionViewDelegate <NSObject>

- (void)optionViewBeganDragging:(OptionView *)optionView;
- (void)optionViewEndDragging:(OptionView *)optionView;

@end