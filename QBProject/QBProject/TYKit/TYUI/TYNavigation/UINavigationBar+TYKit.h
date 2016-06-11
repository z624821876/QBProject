//
//  UINavigationBar+TYKit.h
//  TYKit
//
//  Created by TimothyYan on 16/2/17.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (TYKit)

/// 获取导航条颜色
-(UIColor *)ty_barTintColor;

/// 修改导航条背景颜色
-(void)ty_modifyBarColor:(UIColor *)barColor;

/// 修改导航条背景Alpha值
-(void)ty_modifyBarColorWithAlpha:(CGFloat)alpha;

/// 修改背景图片
-(void)ty_modifyBarBackgroundImage:(UIImage *)backgroundImage;

@end
