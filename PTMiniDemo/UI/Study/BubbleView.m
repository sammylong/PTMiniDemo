//
//  BubbleView.m
//  PTMiniDemo
//
//  Created by Sammy Long on 13/4/17.
//  Copyright (c) 2013年 Apexlearn Inc. All rights reserved.
//

#import "BubbleView.h"
#import "UIColor+ptmini.h"
#import "UIImage+ptmini.h"


static const CGFloat cMinimumScale = 0.01f;
static const CGFloat cDefaultWidth  = 50.0f;
static const CGFloat cDefaultHeight = cDefaultWidth;

@interface BubbleView () {
    
}
@end


@implementation BubbleView

- (id)initWithColor:(UIColor *)color {
    // bleh
    self = [super initWithFrame:CGRectMake(  0.0f
                                           , 0.0f
                                           , cDefaultWidth
                                           , cDefaultHeight)];
    if (self) {
        CGFloat radius = roundf(CGRectGetHeight(self.bounds)/2.0f);
        UIImage *image = [UIImage piStretchableRoundedRectImageWithCornerRadius:radius lineWidth:0.0f strokeColor:nil fillColor:color];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = self.bounds;
        [self insertSubview:imageView atIndex:0];// lowest
        
        self.textLabel.font = [UIFont boldSystemFontOfSize:20.0f];
        self.textLabel.textColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setText:(NSString *)text {
    [super setText:text];
    // put it in the center of the view
    CGPoint center = CGPointMake(  CGRectGetMidX(self.bounds)
                                 , CGRectGetMidY(self.bounds));
    self.textLabel.center = center;
}

- (void)showInView:(UIView *)view
          animated:(BOOL)animated
          duration:(NSTimeInterval)duration
             delay:(NSTimeInterval)delay
        completion:(ALCompletionBlock)completionBlock {
    if (animated) {
        CGFloat factor = cMinimumScale;
        // shrink the view to really small, prepare it to expand
        self.transform = CGAffineTransformMakeScale(factor, factor);
        [view addSubview:self];
        [UIView animateWithDuration:duration
                              delay:delay
                            options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             CGFloat factor = 1.0f;
                             self.transform = CGAffineTransformMakeScale(factor, factor);
                         } completion:^(BOOL finished) {
                             if (finished) {
                                 if (completionBlock) {
                                     completionBlock();
                                 }
                             }
                         }];
    } else {
        CGFloat factor = 1.0f;
        self.transform = CGAffineTransformMakeScale(factor, factor);
        [view addSubview:self];
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
                            options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             CGFloat factor = cMinimumScale;
                             self.transform = CGAffineTransformMakeScale(factor, factor);
                         } completion:^(BOOL finished) {
                             [self removeFromSuperview];
                             if (completionBlock) {
                                 completionBlock();
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
