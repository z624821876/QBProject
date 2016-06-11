//
//  NSDate+TYKit.m
//  ULove
//
//  Created by TimothyYan on 16/3/21.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import "NSDate+TYKit.h"

@implementation NSDate (TYKit)

- (NSDateComponents *)components{
    NSCalendar *calendar=[NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSWeekdayCalendarUnit;
    return [calendar components:unit fromDate:self];
}

- (NSDate *)offsetWithType:(tyDateComponentType)type value:(NSInteger)value{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [gregorian setFirstWeekday:2];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    switch (type) {
        case tyDateComponentSeconds:{
            [offsetComponents setSecond:value];
        }
            break;
        case tyDateComponentMinutes:{
            [offsetComponents setMinute:value];
        }
            break;
        case tyDateComponentHours:{
            [offsetComponents setHour:value];
        }
            break;
        case tyDateComponentDays:{
            [offsetComponents setDay:value];
        }
            break;
        case tyDateComponentMonths:{
            [offsetComponents setMonth:value];
        }
            break;
            
        default:
            break;
    }
    return [gregorian dateByAddingComponents:offsetComponents toDate:self options:0];
}

- (NSDate *)offsetDaysWithValue:(NSInteger)value {
    return [self offsetWithType:tyDateComponentDays value:value];
}

- (NSString *)weekend{
    switch (self.components.weekday) {
        case 1:{
            return @"周日";
        }
            break;
        case 2:{
            return @"周一";
        }
            break;
        case 3:{
            return @"周二";
        }
            break;
        case 4:{
            return @"周三";
        }
            break;
        case 5:{
            return @"周四";
        }
            break;
        case 6:{
            return @"周五";
        }
            break;
        case 7:{
            return @"周六";
        }
            break;
        default:{
            return @"错误";
        }
            break;
    }
}

- (NSString *)formatterWithText:(NSString *)text{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:text];
    return [formatter stringFromDate:self];
}

- (NSString *)formatterWithType:(tyDateFormatterType)type{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    switch (type) {
        case tyDateFormatterTypeHm:{
            [formatter setDateFormat:@"HH:mm"];
        }
            break;
        case tyDateFormatterTypeYMD:{
            [formatter setDateFormat:@"YYYY-MM-dd"];
        }
            break;
        case tyDateFormatterTypeYMDHm:{
            [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
        }
            break;
        case tyDateFormatterTypeMD:{
            [formatter setDateFormat:@"MM-dd"];
        }
            break;
        case tyDateFormatterTypeYMDHms:{
            [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        }
            break;
        default:
            break;
    }
    return [formatter stringFromDate:self];
}

- (BOOL)isDayEqualTo:(NSDate *)date type:(tyDateFormatterType)type{
    NSInteger year = [self components].year;
    NSInteger month = [self components].month;
    NSInteger day = [self components].day;
    NSInteger hour = [self components].hour;
    NSInteger minute = [self components].minute;
    
    switch (type) {
        case tyDateFormatterTypeHm:{
            return (hour == [date components].hour && minute == [date components].minute);
        }
            break;
        case tyDateFormatterTypeMD:{
            return (month == [date components].month && day == [date components].day);
        }
            break;
        case tyDateFormatterTypeYMD:{
            return (year == [date components].year && month == [date components].month && day == [date components].day);
        }
            break;
        case tyDateFormatterTypeYMDHm:{
            return (year == [date components].year && month == [date components].month && day == [date components].day && hour == [date components].hour && minute == [date components].minute);
        }
            break;
            
        default:
            break;
    }
    return NO;
}

- (NSDate *)beijingDate {
    return [[NSDate date] offsetWithType:tyDateComponentHours value:8];
}

- (NSDate *)trimTailTimeInterval {
    return [NSDate dateWithTimeIntervalSince1970:self.timeIntervalSince1970 - ((int)self.timeIntervalSince1970 % tyDateDay)];
}

@end
