//
//  ALTypes.h
//  AudioRecorder
//
//  Created by Sammy Long on 12/9/27.
//  Copyright (c) 2012年 Apexlearn Inc. All rights reserved.
//

#ifndef ParrotTalksIOS_ALTypes_h
#define ParrotTalksIOS_ALTypes_h

typedef void(^ALCompletionBlock)(void);
typedef void(^ALSuccessBlock)(void);
typedef void(^ALArraySuccessBlock)(NSArray * array);
typedef void(^ALFailureBlock)(NSError * error);
#endif
