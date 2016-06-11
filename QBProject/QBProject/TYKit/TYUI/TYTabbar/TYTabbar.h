//
//  TYTabbar.h
//  TYKit
//
//  Created by QuincyYan on 16/4/10.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYTabbarEntity.h"

@class TYTabbar;
@protocol TYTabbarDelegate <NSObject>

/// 点击的代理
-(BOOL)TYTabbar:(TYTabbar *)TYTabbar didSelectedEntityInIndex:(NSInteger)index;

@end

@class TYTabbarEntity;

/// TYTabbar继承自UIToolbar会有一条阴影线在上方
/// 如果继承自UIView会良好改善
@interface TYTabbar : UIToolbar

/// 代理
@property (nonatomic,weak) id<TYTabbarDelegate> tyDelegate;

/// 子结构
@property (nonatomic,strong) NSArray *entitys;

/// 初始选中的序列号
/// 默认为0
@property (nonatomic) NSInteger selectedIndex;

/// 默认状态下的背景色
/// 默认为白色
@property (nonatomic,strong) UIColor *normalStateBackgroundColor;

/// 选中状态下的背景色
/// 默认为白色
@property (nonatomic,strong) UIColor *selectedStateBackgroundColor;

/// 普通状态下的字体颜色
/// 默认为黑色
@property (nonatomic,strong) UIColor *normalStateTextColor;

/// 选中状态下的字体颜色
/// 默认为蓝色
@property (nonatomic,strong) UIColor *selectedStateTextColor;

/// 角标
- (void)entityWithBadge:(NSInteger)badge atIndex:(NSInteger)index;

/// 移除所有角标
- (void)removeAllBadges;

/// 移除一个角标
- (void)removeBadgeAtIndex:(NSInteger)index;

/// 重载数据源
- (void)reloadEntitys;

@end
