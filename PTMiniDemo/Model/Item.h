//
//  Item.h
//  PTMiniDemo
//
//  Created by Sammy Long on 13/4/11.
//  Copyright (c) 2013年 Apexlearn Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Catalog;

@interface Item : NSManagedObject

@property (nonatomic, retain) NSString * answer;
@property (nonatomic, retain) NSString * audioName;
@property (nonatomic, retain) NSString * imageName;
@property (nonatomic, retain) NSDate * lastStudiedDate;
@property (nonatomic, retain) NSString * detail;
@property (nonatomic, retain) Catalog *catalog;

@end
