//
//  NSObject+Property.h
//  ULove
//
//  Created by TimothyYan on 16/3/21.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Property)

/// 通过Ivar获取类中的所有参数
+ (NSArray *)propertys;

/// 获取类中的一个属性的值
- (id)valueOfKey:(NSString *)key;

/// 完全复制一个对象
- (id)classCopy;

/// 所有的属性值转换成字典
- (NSDictionary *)propertyToDictionary;

@end
