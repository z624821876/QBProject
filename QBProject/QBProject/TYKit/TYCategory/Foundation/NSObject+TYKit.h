//
//  NSObject+TYKit.h
//  ULove
//
//  Created by TimothyYan on 16/3/21.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (TYKit)

/// 拨打电话
+ (void)callWithNumber:(NSString *)number;

/// 打开链接
+ (void)openWithURL:(NSString *)URL;

/// 获取设备名称
+ (NSString *)deviceName;

/// 获取对外版本号
+ (NSString *)shortVersion;

/// 获取bundleID
+ (NSString *)bundleId;

/// 获取UUID
+ (NSString *)UUID;

/// 验证模型中的所有属性是否都不为空
- (BOOL)isModelTotallyNotEmpty;

@end
