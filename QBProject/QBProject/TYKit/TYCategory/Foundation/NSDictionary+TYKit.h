//
//  NSDictionary+TYKit.h
//  ULove
//
//  Created by TimothyYan on 16/3/21.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (TYKit)

/// 对字典中的key进行排序
/// 例如: a=1&b=2&c=3
- (NSString *)serializeKeys;

/// 添加另外一个字典的数据
- (NSDictionary *)keysWithOther:(NSDictionary *)dic;

/// 转换成XML
- (NSString *)XMLString;

@end
