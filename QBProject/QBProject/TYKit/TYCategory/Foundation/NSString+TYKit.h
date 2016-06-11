//
//  NSString+TYKit.h
//  ULove
//
//  Created by TimothyYan on 16/3/21.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TYKit)

/// 计算尺寸
/// Attribute默认只有为字体大小
/// Linebreakmode为默认
- (CGSize)sizeWithFont:(NSUInteger)font maxSize:(CGSize)maxSize;

/// 是否包含某个字符串
- (BOOL)stringContains:(NSString *)string;

/// 清除空格
- (NSString *)clearWhiteSpace;

/// 清除空格和回车键
- (NSString *)clearWhiteSpaceWithEmptyLine;

/// 返回一个随机字符串
- (NSString *)randomString;

/// JSON字符串转化成字典
- (NSDictionary *)JSONToDic;

/// MD5加密
- (NSString *)MD5Encode;

/// HMACSHA1加密
- (NSData *)HMACSHA1EncodeWithKey:(NSString *)key;

/// SHA1加密 Secure Hash Algorithm
- (NSString *)SHA1Encode;

/// SHA224加密
- (NSString *)SHA224Encode;

/// SHA256加密
- (NSString *)SHA256Encode;

/// SHA385加密
- (NSString *)SHA384Encode;

/// SHA512加密
- (NSString *)SHA512Encode;

@end
