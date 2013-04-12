//
//  NSDate+Apexlearn.m
//  ParrotTalks
//
//  Created by Sammy Long on 13/1/16.
//  Copyright (c) 2013年 Apexlearn Inc. All rights reserved.
//

#import "NSDate+Apexlearn.h"

@implementation NSDate (Apexlearn)

- (NSDate *)apexFloorDayWithCalendar:(NSCalendar *)calendar {
    NSCalendar *cal = calendar ? calendar : [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [cal components:(  NSEraCalendarUnit
											   | NSYearCalendarUnit
											   | NSMonthCalendarUnit
											   | NSDayCalendarUnit
											   )
									 fromDate:self];
    
	NSDate *result = [cal dateFromComponents:comps];
	return result;
}

- (NSDate *)apexFloorWeekWithCalendar:(NSCalendar *)calendar {
    NSCalendar *cal = calendar ? calendar : [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];    // Get the weekday component of the self
    NSDateComponents *weekdayComponents = [cal components:NSWeekdayCalendarUnit
                                                      fromDate:self];
    NSDateComponents *componentsToSubtract =  [[NSDateComponents alloc] init];
    [componentsToSubtract setDay:0 - ([weekdayComponents weekday] - 1)];
    
    NSDate *beginningOfWeek = [cal dateByAddingComponents:componentsToSubtract
                                                        toDate:[self apexFloorDayWithCalendar:cal]
                                                       options:0];
    return beginningOfWeek;
}

- (NSDate *)apexFloorMonthWithCalendar:(NSCalendar *)calendar {
    NSCalendar *cal = calendar ? calendar : [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [cal components:(  NSEraCalendarUnit
											   | NSYearCalendarUnit
											   | NSMonthCalendarUnit
											   )
									 fromDate:self];
	NSDate *result = [cal dateFromComponents:comps];
	return result;
}

- (NSInteger)apexYearComponentWithCalendar:(NSCalendar *)calendar {
    NSCalendar *cal = calendar ? calendar : [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [cal components:NSYearCalendarUnit fromDate:self];
    NSInteger year = [comps year];
    return (year < 0 ? 0: year);
}

- (NSInteger)apexMonthComponentWithCalendar:(NSCalendar *)calendar {
    NSCalendar *cal = calendar ? calendar : [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [cal components:NSMonthCalendarUnit fromDate:self];
    NSInteger month = [comps month];
    return (month < 0 ? 0: month);
}

- (NSInteger)apexDayComponentWithCalendar:(NSCalendar *)calendar {
    NSCalendar *cal = calendar ? calendar : [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [cal components:NSDayCalendarUnit fromDate:self];
    NSInteger day = [comps day];
    return (day < 0 ? 0: day);
}

- (NSDate *)apexNextDayWithCalendar:(NSCalendar *)calendar {
    NSCalendar *cal = calendar ? calendar : [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *oneDay = [[NSDateComponents alloc] init];
    [oneDay setDay:1];
    NSDate * nextDate = [cal dateByAddingComponents:oneDay toDate:[self apexFloorDayWithCalendar:cal] options:0];
    return nextDate;
}

- (NSDate *)apexPreviousDayWithCalendar:(NSCalendar *)calendar {
    NSCalendar *cal = calendar ? calendar : [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *oneDay = [[NSDateComponents alloc] init];
    [oneDay setDay:-1];
    NSDate * previousDate = [cal dateByAddingComponents:oneDay toDate:[self apexFloorDayWithCalendar:cal] options:0];
    return previousDate;
}

- (NSDate *)apexDateByAddingDays:(NSInteger)days withCalendar:(NSCalendar *)calendar {
    NSCalendar *cal = calendar ? calendar : [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:days];
    NSDate * nextDate = [cal dateByAddingComponents:comps toDate:[self apexFloorDayWithCalendar:cal] options:0];
    return nextDate;
}

- (BOOL)apexIsOnSameDayAsDate:(NSDate *)otherDate withCalendar:(NSCalendar *)calendar {
    NSCalendar *cal = calendar ? calendar : [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDate *selfFloored = [self apexFloorDayWithCalendar:cal];
	NSDate *otherDateFloored = [otherDate apexFloorDayWithCalendar:cal];
	NSDateComponents *separatingComponents = [cal components:(  NSDayCalendarUnit
															  )
													fromDate:otherDateFloored
													  toDate:selfFloored
													 options:0
											  ];
	return (separatingComponents.day == 0);
}

@end
