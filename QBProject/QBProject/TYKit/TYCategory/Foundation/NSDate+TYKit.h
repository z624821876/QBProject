//
//  NSDate+TYKit.h
//  ULove
//
//  Created by TimothyYan on 16/3/21.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import <Foundation/Foundation.h>

#define tyDateDay (24 * 60 * 60)

typedef NS_ENUM(NSUInteger,tyDateComponentType) {
    tyDateComponentSeconds = 0,
    tyDateComponentMinutes = 1,
    tyDateComponentHours   = 2,
    tyDateComponentDays    = 3,
    tyDateComponentMonths  = 4,
};

typedef NS_ENUM(NSUInteger,tyDateFormatterType) {
    tyDateFormatterTypeYMD   = 0,
    tyDateFormatterTypeHm    = 1,
    tyDateFormatterTypeYMDHm = 2,
    tyDateFormatterTypeMD    = 3,
    tyDateFormatterTypeYMDHms = 4,
};

@interface NSDate (TYKit)

/// 获取时间的部分
- (NSDateComponents *)components;

/// 根据间隔设置时间
- (NSDate *)offsetWithType:(tyDateComponentType)type value:(NSInteger)value;

/// 获取间隔天数的时间
- (NSDate *)offsetDaysWithValue:(NSInteger)value;

/// 回调今天星期几
- (NSString *)weekend;

/// 格式化
- (NSString *)formatterWithText:(NSString *)text;

/// 返回特定格式化格式的内容
- (NSString *)formatterWithType:(tyDateFormatterType)type;

/// 两个时间YMD是否相同
- (BOOL)isDayEqualTo:(NSDate *)date type:(tyDateFormatterType)type;

/// 北京时间
- (NSDate *)beijingDate;

/// 获取一个整天数的时间
- (NSDate *)trimTailTimeInterval;

@end
