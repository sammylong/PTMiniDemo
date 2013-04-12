//
//  ALLog.h
//  ParrotTalks
//
//  Created by Sammy Long on 13/3/25.
//  Copyright (c) 2013年 Apexlearn Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

void ALLogHelper(const char *filepath, int line, NSString *message);
void ALLogSetBlock(void(^block)(const char *filepath, int line, NSString *message));

#ifdef DEBUG
#define ALLog( s, ... ) ALLogHelper( __FILE__, __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__])
#else
#define ALLog( s, ... )
#endif