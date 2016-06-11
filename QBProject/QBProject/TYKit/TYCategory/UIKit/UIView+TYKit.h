//
//  UIView+TYKit.h
//  ULove
//
//  Created by TimothyYan on 16/3/21.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ gestureTapBlock)();

@interface UIView (TYKit)

/// 初始化一个带颜色的控件
+ (UIView *)viewWithColor:(UIColor *)color;

/// 添加一个点击事件
- (void)handleTapGestureWithBlock:(gestureTapBlock)block;

/// 添加边框
- (void)cornerRadius:(CGFloat)radius width:(CGFloat)width color:(UIColor *)color;

/// 移除所有子视图
- (void)removeAllSubviews;

/// 移除所有特定类的子视图
- (void)removeAllSubviewsWithType:(Class)type;

/// 为视图添加一个背景图
- (void)viewWithBackgroundImage:(UIImage *)backgroundImage;

/// 为视图添加一个背景图
- (void)viewWithBackgroundImage:(UIImage *)backgroundImage withAlpha:(CGFloat)alpha;

/// 呼出键盘
- (void)viewContainsTextFieldShouldAppear;

/// 隐藏键盘
- (void)viewContainsTextFieldShouldResign;

/// 添加横线
- (void)viewInsertSplitIsContainsTop:(BOOL)top topPadding:(CGFloat)topPadding andBottom:(BOOL)bottom bottomPadding:(CGFloat)bottomPadding;

/// 宽度
- (CGFloat)width;

/// 高度
- (CGFloat)height;

/// X坐标
- (CGFloat)x;

/// Y坐标
- (CGFloat)y;

@end
