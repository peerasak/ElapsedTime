//
//  ElapsedTimeCalculator.m
//  HighRise
//
//  Created by Peerasak on 10/5/12.
//  Copyright (c) 2012 Peerasak. All rights reserved.
//
//  Example: [ElapsedTimeCalculator elapsedTimeFrom:@"2012-10-05 23:09:34" withFormat:@"yyyy-MM-dd HH:mm:ss"]

#import "ElapsedTimeCalculator.h"

@implementation ElapsedTimeCalculator

+ (NSString *)elapsedTimeFrom:(NSString *)time withFormat:(NSString *)format
{
    NSString *elapsedTime;
    
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:sourceTimeZone];
    [formatter setDateFormat:format];
    
    NSDate *dateFromString = [formatter dateFromString:time];

    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|   NSHourCalendarUnit|NSMinuteCalendarUnit|NSWeekCalendarUnit
                                               fromDate:dateFromString
                                                 toDate:[self getCurrentDate]
                                                options:0];
    if (components.year < 1) {
        if (components.month < 1) {
            if (components.week < 1) {
                if (components.day < 1) {
                    if (components.hour < 1) {
                        if (components.minute < 1) {
                            if (components.second < 5) {
                                elapsedTime = [NSString stringWithFormat:@"a few seconds ago"];
                                return elapsedTime;
                            }else if (components.second > 60){
                                elapsedTime = [NSString stringWithFormat:@"a few seconds ago"];
                                return elapsedTime;
                            }else {
                                elapsedTime = [NSString stringWithFormat:@"%i seconds ago",components.second];
                                return elapsedTime;
                            }
                        }else if (components.minute == 1 && components.second > 10) {
                            elapsedTime = [NSString stringWithFormat:@"about a minute ago"];
                            return elapsedTime;
                        }else if (components.minute == 1) {
                            elapsedTime = [NSString stringWithFormat:@"a minute ago"];
                            return elapsedTime;
                        }else {
                            elapsedTime = [NSString stringWithFormat:@"%i minutes ago",components.minute];
                            return elapsedTime;
                        }
                    }else if (components.hour == 1 && components.minute > 10){
                        elapsedTime = [NSString stringWithFormat:@"about an hour ago"];
                        return elapsedTime;
                    }else if (components.hour == 1) {
                        elapsedTime = [NSString stringWithFormat:@"an hour ago"];
                        return elapsedTime;
                    }else {
                        elapsedTime = [NSString stringWithFormat:@"%i hours ago",components.hour];
                        return elapsedTime;
                    }
                }else if(components.day == 1){
                    elapsedTime = [NSString stringWithFormat:@"a day ago"];
                    return elapsedTime;
                }else {
                    elapsedTime = [NSString stringWithFormat:@"%i days ago",components.day];
                    return elapsedTime;
                }
            }else if(components.week == 1) {
                elapsedTime = [NSString stringWithFormat:@"a week ago"];
                return elapsedTime;
            }else {
                elapsedTime = [NSString stringWithFormat:@"%i weeks ago",components.week];
                return elapsedTime;
            }
        }else if(components.month == 1) {
            elapsedTime = [NSString stringWithFormat:@"a month ago"];
            return elapsedTime;
        }else {
            elapsedTime = [NSString stringWithFormat:@"%i months ago",components.month];
            return elapsedTime;
        }
    }else if (components.year == 1) {
        elapsedTime = [NSString stringWithFormat:@"a year ago"];
        return elapsedTime;
    }else {
        elapsedTime = [NSString stringWithFormat:@"%i years ago",components.year];
        return elapsedTime;
    }
    return elapsedTime;
}

+ (NSDate *)getCurrentDate
{
    NSDate* sourceDate = [NSDate date];
    
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
    
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    
    
    NSDate* destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];
    return destinationDate;
}

@end
