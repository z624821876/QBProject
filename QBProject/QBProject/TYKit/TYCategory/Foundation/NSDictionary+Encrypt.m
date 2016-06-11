//
//  NSDictionary+Encrypt.m
//  MagicMask
//
//  Created by yanyibin on 16/4/7.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import "NSDictionary+Encrypt.h"

static NSString *const serverPublicKey = @"a5063dce1b2d2013de0b9f40cb25c5c1";

@implementation NSDictionary (Encrypt)

/// 加密
- (NSDictionary *)encrypt {
    /// 随机时间,毫秒级别
    UInt64 randomTime = [[NSDate date] timeIntervalSince1970] * 1000;
    /// 获取其他的加密必备的参数
    NSDictionary *otherKeys = @{@"randomTime":@(randomTime),
                                @"appVersion":[NSObject shortVersion],
                                @"deviceName":[NSObject deviceName],
                                @"deviceType":@"ios"};
    
    NSMutableDictionary *fullKeys = [[NSMutableDictionary alloc] initWithDictionary:[self keysWithOther:otherKeys]];
    NSString *signKey = [fullKeys serializeKeys];
    
//    if ([MMUserModel isUserLogin].boolValue) {
//        NSString *userId = [MMUserModel currUser].userId;
//        if (userId&&userId.length>0) {
//            signKey = [signKey stringByAppendingString:userId];
//        }
//    }
    
    signKey = [[[signKey stringByAppendingString:serverPublicKey] MD5Encode] lowercaseString];
    [fullKeys setObject:signKey forKey:@"sign"];
    
    return fullKeys;
}

/// 加密,主要用于传空字典
+ (NSDictionary *)encryptEmpty {
    return [[[NSDictionary alloc] init] encrypt];
}

@end
