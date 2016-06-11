//
//  TYTabbarEntity.h
//  MPProject
//
//  Created by QuincyYan on 16/5/27.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TYTabbarEntity : UIControl

/// 角标
@property (nonatomic) NSInteger badgeValue;

/// 是否角标只是显示小红点
/// 默认为‘NO’
@property (nonatomic) BOOL isOnlyDisplayRedSpot;

/// 角标字体
@property (nonatomic,strong) UIFont *badgeSystemFont;

/// 普通状态下的属性
@property (nonatomic,strong) NSDictionary *normalStateTextAttribute;

/// 选中状态下的属性
@property (nonatomic,strong) NSDictionary *selectedStateTextAttribute;

/// 字体
/// 默认为12
@property (nonatomic,strong) UIFont *normalStateSystemFont;

/// 选中状态下的字体
@property (nonatomic,strong) UIFont *selectedStateSystemFont;

/// 默认状态下的背景色,默认为白色
@property (nonatomic,strong) UIColor *normalStateBackgroundColor;

/// 选中状态下的背景色,默认为白色
@property (nonatomic,strong) UIColor *selectedStateBackgroundColor;

/// 普通状态下的字体颜色,默认为黑色
@property (nonatomic,strong) UIColor *normalStateTextColor;

/// 选中状态下的字体颜色,默认为蓝色
@property (nonatomic,strong) UIColor *selectedStateTextColor;

/// 标题
@property (nonatomic,copy) NSString *title;

/// 普通状态下的按钮
@property (nonatomic,copy) NSString *normalStateIcon;

/// 选中状态下的按钮
@property (nonatomic,copy) NSString *selectedStateIcon;

@end
