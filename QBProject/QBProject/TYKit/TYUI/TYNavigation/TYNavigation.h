//
//  TYNavigation.h
//  TYKit
//
//  Created by TimothyYan on 16/2/17.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UINavigationBar+TYKit.h"

@interface TYNavigation : NSObject

/// 导航条背景颜色
@property (nonatomic,strong) UIColor *backgroundColor;

/// 导航条背景颜色Alpha值
@property (nonatomic) CGFloat barColorAlpha;

/// 导航条左右控件颜色
@property (nonatomic,strong) UIColor *tintColor;

/// 导航条字体颜色
@property (nonatomic,strong) UIColor *titleColor;

/// 导航条字体
@property (nonatomic,strong) NSMutableDictionary *titleArrtibute;

/// 阴影图片
@property (nonatomic,strong) UIImage *shadowImage;

/// 状态栏是否改变成白色
/// View controller-based Status Bar Appearance 必须设置为No
@property (nonatomic) UIStatusBarStyle statusBarStyle;

/// 是否隐藏navigationBar
@property (nonatomic) BOOL isHiddenNavigationBar;

/// 视图将要出现的时候
-(void)ty_viewWillAppear;

/// 视图将要消失的时候
-(void)ty_viewWillDisappear;

/// 初始化
-(instancetype)initWithNavigationBar:(UINavigationBar *)navigationBar;

@end