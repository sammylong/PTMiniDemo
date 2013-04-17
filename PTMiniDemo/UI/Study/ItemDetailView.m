//
//  ItemDetailView.m
//  PTMiniDemo
//
//  Created by Sammy Long on 13/4/11.
//  Copyright (c) 2013年 Apexlearn Inc. All rights reserved.
//

#import "ItemDetailView.h"
#import "UIColor+ptmini.h"
#import "UIImage+ptmini.h"
#import <AVFoundation/AVFoundation.h>
#import "OptionView.h"
#import <AVFoundation/AVFoundation.h>


@interface ItemDetailView () <AVAudioPlayerDelegate> {
    AVAudioPlayer *_audioPlayer;
}

@property (nonatomic, strong) UIView *circleView;
@property (nonatomic, strong) UIImageView *imageView;

@end


@implementation ItemDetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat radius = 280.0f;
        UIColor *strokeColor = [UIColor piLightGrayColor];
        UIColor *fillColor = [UIColor piLightLightGrayColor];
        UIImage *image = [UIImage piStretchableRoundedRectImageWithCornerRadius:radius lineWidth:2.0f strokeColor:strokeColor fillColor:fillColor];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), radius);
        imageView.center = center;
        [self addSubview:imageView];
        self.circleView = imageView;
        
        // add gesture recognizer
        UISwipeGestureRecognizer *swipeUpGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedUp:)];
        swipeUpGestureRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
        [self addGestureRecognizer:swipeUpGestureRecognizer];
        UISwipeGestureRecognizer *swipeDownGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedDown:)];
        swipeDownGestureRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
        [self addGestureRecognizer:swipeDownGestureRecognizer];
    }
    return self;
}


#pragma mark Public

- (void)setImage:(UIImage *)image animated:(BOOL)animated {
    if (animated) {
        NSTimeInterval animDuration = 0.4;
        // new imageview
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.image = image;
        CGFloat size = CGRectGetWidth(self.bounds) * 0.4f;
        CGRect rect = CGRectMake(0.0f, 0.0f, size, size);
        CGRect bounds = AVMakeRectWithAspectRatioInsideRect(image.size, rect);
        imageView.bounds = bounds;
        CGFloat y = size + 40.0f;
        CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), y);
        imageView.center = center;
        imageView.alpha = 0.0f;
        [self addSubview:imageView];
        ItemDetailView *weakSelf = self;
        [UIView animateWithDuration:animDuration
                         animations:^{
                             weakSelf.imageView.alpha = 0.0f;
                         }
                         completion:^(BOOL finished) {
                             [weakSelf.imageView removeFromSuperview];
                         }];
        [UIView animateWithDuration:animDuration
                              delay:0.3
                            options:UIViewAnimationCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             imageView.alpha = 1.0f;
                         } completion:^(BOOL finished) {
                             weakSelf.imageView = imageView;

                         }];
    } else {
        // new imageview
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.image = image;
        CGFloat size = CGRectGetWidth(self.bounds) * 0.4f;
        CGRect rect = CGRectMake(0.0f, 0.0f, size, size);
        CGRect bounds = AVMakeRectWithAspectRatioInsideRect(image.size, rect);
        imageView.bounds = bounds;
        CGFloat y = size + 20.0f;
        CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), y);
        imageView.center = center;
        [self addSubview:imageView];
        self.imageView = imageView;
    }
}

- (void)setPlaceHolder:(UIView *)placeHolder {
    [_placeHolder removeFromSuperview];
    _placeHolder = placeHolder;
    [self addSubview:placeHolder];
}

- (void)setAnswerView:(OptionView *)answerView {
    [_answerView removeFromSuperview];
    _answerView = answerView;
    if (answerView.superview != self) {
        answerView.center = self.placeHolder.center;
        [answerView showInView:self animated:NO duration:0.0 delay:0.0 completion:nil];
    }
}

- (void)play {
    if (self.audioName) {
        // Init audio with playback capability
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
        NSArray *comps = [self.audioName componentsSeparatedByString:@"."];
        if ([comps count] != 2) {
            return;
        }
        NSString *name = [comps objectAtIndex:0];
        NSString *extension = [comps objectAtIndex:1];
        NSURL *url = [[NSBundle mainBundle] URLForResource:name withExtension:extension];
        NSError *error = nil;
        _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        _audioPlayer.delegate = self;
        if (error) {
            NSLog(@"Error init audio player: %@ - %@)" , error, error.userInfo);
            return;
        }
        _audioPlayer.numberOfLoops = 0;
        if ([_audioPlayer prepareToPlay]) {
            [_audioPlayer play];
        }

    }
}

- (void)bounceCircleWithCompletion:(ALCompletionBlock)completionBlock {
/*
    ALAnimationCompletionBlock fifthAnimation = ^(BOOL finished) {
        if (finished) {
            // back to normal
            [self resizeCircleToScale:CGPointMake(1.0f, 1.0f)
                             duration:0.05
                                delay:0.0
                           completion:^(BOOL finished) {
                               if (completionBlock) {
                                   completionBlock();
                               }
                           }];
        } else {
            completionBlock();
        }
    };
    ALAnimationCompletionBlock fourthAnimation = ^(BOOL finished) {
        if (finished) {
            // shrink
            [self resizeCircleToScale:CGPointMake(0.97f, 0.99f)
                             duration:0.1
                                delay:0.0
                           completion:fifthAnimation];
        } else {
            completionBlock();
        }
    };
*/
    ALAnimationCompletionBlock thirdAnimation = ^(BOOL finished) {
        if (finished) {
            // grow
            [self resizeCircleToScale:CGPointMake(1.0f, 1.0f)
                             duration:0.2
                                delay:0.0
                           completion:^(BOOL finished) {
                               if (finished) {
                                   if (completionBlock) {
                                       completionBlock();
                                   }
                               }
                           }];
        } else {
            completionBlock();
        }
    };
    ALAnimationCompletionBlock secondAnimation = ^(BOOL finished) {
        if (finished) {
            // shrink
            [self resizeCircleToScale:CGPointMake(0.96f, 0.98f)
                             duration:0.2
                                delay:0.0
                           completion:thirdAnimation];
        } else {
            completionBlock();
        }
    };
    [self resizeCircleToScale:CGPointMake(1.04f, 1.02f)
                     duration:0.25
                        delay:0.0
                   completion:secondAnimation];
}


#pragma mark Private

- (void)swipedUp:(UISwipeGestureRecognizer *)swipeGestureRecognizer {
    [self.delegate itemDetailViewSwipedUp:self];
}

- (void)swipedDown:(UISwipeGestureRecognizer *)swipeGestureRecognizer {
    [self.delegate itemDetailViewSwipedDown:self];
}


#pragma mark Animation Module

- (void)resizeCircleToScale:(CGPoint)scale
                   duration:(NSTimeInterval)duration
                      delay:(NSTimeInterval)delay
                 completion:(ALAnimationCompletionBlock)completionBlock {
    [UIView animateWithDuration:duration
                          delay:delay
                        options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.circleView.transform = CGAffineTransformMakeScale(scale.x, scale.y);
                     } completion:completionBlock];
}


#pragma mark AV audio player delegate

- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player withOptions:(NSUInteger)flags {
    if (flags == AVAudioSessionInterruptionOptionShouldResume) {
        [player play];
    }
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    if (flag) {
        // inform delegate
        [self.delegate itemDetailViewDidFinishPlaying:self];
    }
}

@end
