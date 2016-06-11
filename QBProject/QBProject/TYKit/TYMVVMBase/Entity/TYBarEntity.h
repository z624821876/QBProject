//
//  TYBarEntity.h
//  MPProject
//
//  Created by QuincyYan on 16/5/24.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TYBarEntity : UIView

/// 字体
/// 默认字体大小为‘17’
@property (nonatomic,strong) UIFont *entityFont;

/// 字体颜色
/// 默认字体颜色为‘[UIColor whiteColor]’
@property (nonatomic,strong) UIColor *entityTextColor;

/// 静态图片
@property (nonatomic,strong) UIImage *entityImage;

/// 伸缩的图片倍数
@property (nonatomic,strong) NSNumber *entityImageScale;

/// 网络加载图片
@property (nonatomic,copy) NSString *entityNetworkImage;

/// 网络加载图片的占位图
@property (nonatomic,strong) UIImage *entityPlaceHolderImage;

/// 网络加载的图片的尺寸
/// 默认为(40, 40)
@property (nonatomic) CGSize entityNetworkSize;

/// 文字
@property (nonatomic,copy) NSString *entityTitle;

/// 按钮
@property (nonatomic,strong) UIButton *entityButton;

/// 自定义按钮尺寸
/// 如果不设置则根据图片与文字判断
@property (nonatomic) CGSize entityButtonSize;

/// 圆角半径
/// 非整个控件都裁剪
/// 主要用于一个圆形的控件需要在其右上角加角标这种需求
/// 作用于‘self.entityButton’
@property (nonatomic,strong) NSNumber *entityCornerRatius;

/// 角标
/// 不显示具体的数字,太大了看不清楚,只显示一个小红点
@property (nonatomic,strong) NSNumber *entityBadgeValue;

/// 整个视图的内边距
@property (nonatomic) UIEdgeInsets contentEdgeInsets;

/// 文字的内边距
/// 默认为(0, 10, 0, 0)
/// 如果只有文字,则内边距为0
@property (nonatomic) UIEdgeInsets titleEdgeInsets;

/// 图片的内边距
@property (nonatomic) UIEdgeInsets imageEdgeInsets;

/// 视图的Alpha值
/// 默认为‘1.0f’
/// 作用于‘self.entityButton’
@property (nonatomic,strong) NSNumber *entityAlpha;

/// 是否按钮可点
/// 状态可随时改变
@property (nonatomic,strong) NSNumber *isEntityButtonTouchable;



/// 类方法
/// 生成一个只有图片的控件
+ (TYBarEntity *)entityWithIcon:(NSString *)entityImage scale:(NSNumber *)entityScale;

/// 类方法
/// 生成只包含文字的控件
+ (TYBarEntity *)entityWithTitle:(NSString *)entityTitle isEntityButtonTouchable:(NSNumber *)touchable;

/// 类方法
/// 生成一个带有返回图片的控件
+ (TYBarEntity *)entityWithDefaultReturnIconWithTitle:(NSString *)entityTitle;


@end
