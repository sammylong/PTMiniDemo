//
//  UIViewController+ALModal.h
//  AudioRecorder
//
//  Created by Sammy Long on 12/9/27.
//  Copyright (c) 2012年 Apexlearn Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ALModal)

@property (nonatomic, copy) ALCompletionBlock finishBlock;
- (void)invokeFinishBlock;

@property (nonatomic, copy) ALCompletionBlock cancelBlock;
- (void)invokeCancelBlock;

@end
