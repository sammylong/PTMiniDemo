//
//  ALSingleton.h
//  ParrotTalks
//
//  Created by Sammy Long on 12/10/24.
//  Copyright (c) 2012年 Apexlearn Inc. All rights reserved.
//

#define AL_SYNTHESIZE_SINGLETON(classname,accessorMethod,initializerBlock) \
\
+ (classname *)accessorMethod\
{\
static classname *sSharedInstance = nil;\
static dispatch_once_t pred;\
dispatch_once(&pred, ^{\
sSharedInstance = [self alloc];\
sSharedInstance = (classname*)initializerBlock(sSharedInstance);\
});\
return sSharedInstance;\
}
