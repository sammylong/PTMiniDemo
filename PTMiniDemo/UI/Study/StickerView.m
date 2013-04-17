//
//  StickerView.m
//  PTMiniDemo
//
//  Created by Sammy Long on 13/4/12.
//  Copyright (c) 2013年 Apexlearn Inc. All rights reserved.
//

#import "StickerView.h"
#import <AVFoundation/AVFoundation.h>

static const CGFloat cDefaultWidth  = 160.0f;
static const CGFloat cDefaultHeight = 40.0f;

@implementation StickerView

- (id)init {

    self = [super initWithFrame:CGRectMake(  0.0f
                                           , 0.0f
                                           , 20.0f
                                           , cDefaultHeight)];
    if (self) {
        self.layer.shadowColor = [UIColor darkGrayColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
        self.layer.shadowRadius = 2.0f;
    }
    return self;
}

- (void)showInView:(UIView *)view
          animated:(BOOL)animated
          duration:(NSTimeInterval)duration
             delay:(NSTimeInterval)delay
        completion:(ALCompletionBlock)completionBlock {
    // TODO
    [view addSubview:self];
    self.alpha = 1.0f;
    if (animated) {
        [UIView animateWithDuration:duration
                              delay:delay
                            options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             // expand self's frame
                             CGRect frame = self.frame;
                             frame.size.width = cDefaultWidth;
                             self.frame = frame;
                         } completion:^(BOOL finished) {
                             if (finished) {
                                 if (completionBlock) {
                                     completionBlock();
                                 }
                             }
                         }];
    } else {
        CGRect frame = self.frame;
        frame.size.width = cDefaultWidth;
        self.frame = frame;
        if (completionBlock) {
            completionBlock();
        }
    }
}

- (void)dismiss:(BOOL)animated
       duration:(NSTimeInterval)duration
          delay:(NSTimeInterval)delay
completionBlock:(ALCompletionBlock)completionBlock {
    if (animated) {
        [UIView animateWithDuration:duration
                              delay:delay
                            options:UIViewAnimationCurveEaseInOut|UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             self.alpha = 0.0f;
                         } completion:^(BOOL finished) {
                             [self removeFromSuperview];
                             if (finished) {
                                 if (completionBlock) {
                                     completionBlock();
                                 }
                             }
                         }];
    } else {
        [self removeFromSuperview];
        if (completionBlock) {
            completionBlock();
        }
    }
}

+ (CGFloat)defaultWidth {
    // child class implement
    return cDefaultWidth;
}
+ (CGFloat)defaultHeight {
    // child class implement
    return cDefaultHeight;
}

@end
