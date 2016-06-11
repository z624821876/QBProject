//
//  UIViewController+TYKit.h
//  ULove
//
//  Created by TimothyYan on 16/3/21.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (TYKit)

/// 查询类中是否有该属性
+ (BOOL)searchWithClass:(Class)class property:(NSString *)property;

/// 初始化一个控制器,并且带参数
+ (UIViewController *)classWithIdentity:(NSString *)identity params:(NSDictionary *)params;

/// 对控制器进行赋值
- (UIViewController *)classWithParams:(NSDictionary *)params;

@end
