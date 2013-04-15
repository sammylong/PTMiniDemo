//
//  StickerView.m
//  PTMiniDemo
//
//  Created by Sammy Long on 13/4/12.
//  Copyright (c) 2013年 Apexlearn Inc. All rights reserved.
//

#import "StickerView.h"
#import <AVFoundation/AVFoundation.h>

@interface StickerView ()

@property (nonatomic, strong) UILabel *textLabel;
@end


@implementation StickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.shadowColor = [UIColor darkGrayColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
        self.layer.shadowRadius = 2.0f;
        
        _textLabel = [[UILabel alloc] init];
        _textLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_textLabel];
    }
    return self;
}

- (void)setText:(NSString *)text {
    [super setText:text];
    _textLabel.text = text;
    [_textLabel sizeToFit];
}

- (void)showInView:(UIView *)view
          animated:(BOOL)animated
          duration:(NSTimeInterval)duration
             delay:(NSTimeInterval)delay
        completion:(ALCompletionBlock)completionBlock {
    // TODO
    [view addSubview:self];
    if (animated) {
        [UIView animateWithDuration:duration
                              delay:delay
                            options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             // expand self's frame
                             CGRect frame = self.frame;
                             frame.size.width = 160.0f;
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
        frame.size.width = 160.0f;
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

@end
