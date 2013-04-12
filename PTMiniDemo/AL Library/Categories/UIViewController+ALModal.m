//
//  UIViewController+ALModal.m
//  AudioRecorder
//
//  Created by Sammy Long on 12/9/27.
//  Copyright (c) 2012年 Apexlearn Inc. All rights reserved.
//

#import "UIViewController+ALModal.h"
#import <objc/runtime.h>

static char const cFinishBlockKey;
static char const cCancelBlockKey;

@implementation UIViewController (ALModal)

- (void)setFinishBlock:(ALCompletionBlock)finishBlock {
	objc_setAssociatedObject(  self                            // object to which association should be added
							 , &cFinishBlockKey                // key
							 , finishBlock                     // associated object
							 , OBJC_ASSOCIATION_COPY_NONATOMIC // policy
							 );
}

- (void)setCancelBlock:(ALCompletionBlock)cancelBlock {
	objc_setAssociatedObject(  self                            // object to which association should be added
							 , &cCancelBlockKey                // key
							 , cancelBlock                     // associated object
							 , OBJC_ASSOCIATION_COPY_NONATOMIC // policy
							 );
}

- (ALCompletionBlock)finishBlock {
	return objc_getAssociatedObject(self, &cFinishBlockKey);
}

- (ALCompletionBlock)cancelBlock {
	return objc_getAssociatedObject(self, &cCancelBlockKey);
}

- (void)invokeFinishBlock {
    
	ALCompletionBlock finishBlock = self.finishBlock;
    
	self.finishBlock = nil;
	self.cancelBlock = nil;
    
	if (finishBlock) {
		finishBlock();
	}
}

- (void)invokeCancelBlock {
    
	ALCompletionBlock cancelBlock = self.cancelBlock;
    
	self.finishBlock = nil;
	self.cancelBlock = nil;
    
	if (cancelBlock) {
		cancelBlock();
	}
}

@end
