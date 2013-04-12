//
//  NSDate+Apexlearn.h
//  ParrotTalks
//
//  Created by Sammy Long on 13/1/16.
//  Copyright (c) 2013年 Apexlearn Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Apexlearn)

- (NSDate *)apexFloorDayWithCalendar:(NSCalendar *)calendar;
- (NSDate *)apexFloorWeekWithCalendar:(NSCalendar *)calendar;
- (NSDate *)apexFloorMonthWithCalendar:(NSCalendar *)calendar;
- (NSInteger)apexYearComponentWithCalendar:(NSCalendar *)calendar;
- (NSInteger)apexMonthComponentWithCalendar:(NSCalendar *)calendar;
- (NSInteger)apexDayComponentWithCalendar:(NSCalendar *)calendar;
- (NSDate *)apexNextDayWithCalendar:(NSCalendar *)calendar;
- (NSDate *)apexPreviousDayWithCalendar:(NSCalendar *)calendar;
- (NSDate *)apexDateByAddingDays:(NSInteger)days withCalendar:(NSCalendar *)calendar;
- (BOOL)apexIsOnSameDayAsDate:(NSDate *)otherDate withCalendar:(NSCalendar *)calendar;

@end
