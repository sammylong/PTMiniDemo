//
//  SyncManager.m
//  PTMiniDemo
//
//  Created by Sammy Long on 13/4/10.
//  Copyright (c) 2013年 Apexlearn Inc. All rights reserved.
//

#import "SyncManager.h"


@implementation SyncManager

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)save:(NSError **)error {
    __block BOOL saved = NO;
    __weak NSManagedObjectContext *context = self.managedObjectContext;
    [context performBlockAndWait:^{ // And Wait
        NSManagedObjectContext *strongContext = context;
        
        // workaround for LARKLIFEIOS-24
        saved = [strongContext obtainPermanentIDsForObjects:[strongContext.insertedObjects allObjects] error:error];
        if (saved == NO) {
            return;
        }
        // now save
        saved = [strongContext save:error];
        if(   saved
           && (strongContext.parentContext != nil)) {
            // save succeeded, save parent
            [strongContext.parentContext performBlock:^{
                NSError __autoreleasing *parentError = nil;
                if([strongContext.parentContext save:&parentError]) {
                    // parent save succeeded
                } else {
                    // error saving parent
                    NSLog(@"Error saving parent context: %@ - %@", parentError, parentError.userInfo);
                }
            }];
        }
    }];
    return saved;
}

@end
