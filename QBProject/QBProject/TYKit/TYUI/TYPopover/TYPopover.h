//
//  TYDisplayer.h
//  TYKit
//
//  Created by QuincyYan on 16/4/10.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    /// 从中间出现
    TYPopoverPositionTypeCenter = 0,
    /// 从底部弹出
    TYPopoverPositionTypeBottom = 1,
}TYPopoverPositionType;

typedef enum {
    /// 普通状态
    /// 标题、内容以及按钮等
    TYPopoverContentTypeCommon = 0,
    /// 自定义
    TYPopoverContentTypeCustom = 1,
}TYPopoverContentType;

typedef void (^ TYPopoverHandler)(NSInteger index);

@interface TYPopover : UIView

/// 展示位置
/// 默认为‘TYPopoverPositionTypeCenter’
@property (nonatomic) TYPopoverPositionType popoverPositionType;

/// 控件展示的方式
/// 默认为‘TYPopoverContentTypeCommon’
@property (nonatomic) TYPopoverContentType popoverContentType;

/// 主控件
@property (nonatomic,strong) UIView *popoverView;

/// 自定义视图
/// 需要设定主视图的‘frame’
/// 该视图会添加于‘主控件’上
/// 该视图会添加对应键盘相应事件,会覆盖手势
@property (nonatomic,strong) UIView *popoverCustomView;

/// 控件的宽度
/// 默认为‘250’
@property (nonatomic,assign) CGFloat popoverDefaultWidth;

/// 按钮的高度
/// 默认为‘50’
@property (nonatomic,assign) CGFloat popoverButtonHeight;

/// 标题
@property (nonatomic,strong) UILabel *popoverTitleLabel;

/// 标题的内边距
@property (nonatomic) UIEdgeInsets popoverTitleEdgeInsets;

/// 详情
@property (nonatomic,strong) UILabel *popoverDetailsLabel;

/// 详情的内边距
@property (nonatomic) UIEdgeInsets popoverDetailsEdgeInsets;

/// 取消按钮
@property (nonatomic,strong) UIButton *popoverCancelButton;

/// 按钮
/// 若子集为‘UIButton’ 默认样式为该‘UIButton’
/// 若子集为‘NSString’ 按钮为默认样式
@property (nonatomic,strong) NSArray *popoverButtons;

/// 按钮的点击回调
/// 如果‘isHiddenPopoverWithTouch’值为‘NO’,会回调该方法,但是不会自动取消视图
@property (nonatomic,copy) TYPopoverHandler handler;

/// 是否隐藏取消按钮
/// 默认‘NO’
@property (nonatomic,assign) BOOL isHiddenCancelButton;

/// 是否点击背景层以取消
/// 默认为‘NO’
@property (nonatomic,assign) BOOL isHiddenPopoverWithTouch;

/// 是否点击按钮不取消视图
/// 默认为‘NO’
@property (nonatomic,assign) BOOL isBanHiddenPopoverWithButton;

/// 是否使强制按钮从上到下排列
/// 默认为‘NO’
@property (nonatomic,assign) BOOL isForceButtonsFlowArrange;

/// 是否视图正在呈现着
@property (nonatomic,assign) BOOL isPopoverStillAlive;

/// 展示视图
- (void)showPopoverInView:(UIView *)inView;

/// 隐藏视图
- (void)hiddenPopover;



/// 类方法
/// 默认加载于‘[UIApplication sharedApplication].keyWindow’上
/// 位置为‘TYPopoverPositionTypeCenter’
/// 不隐藏‘取消按钮’
/// 点击背景视图不取消视图
+ (TYPopover *)showPopoverWithTitle:(NSString *)title detailsText:(NSString *)detailsText cancelButtonTitle:(NSString *)cancelButtonTitle otherButtons:(NSArray *)otherButtons completeHandler:(TYPopoverHandler)handler;

/// 类方法
/// 默认加载于‘[UIApplication sharedApplication].keyWindow’上
/// 位置为‘TYPopoverPositionTypeBottom’
/// 隐藏‘取消按钮’
/// 点击背景视图不取消视图
+ (TYPopover *)showSheetPopoverWithTitle:(NSString *)title detailsText:(NSString *)detailsText otherButtons:(NSArray *)otherButtons completeHandler:(TYPopoverHandler)handler;

/// 类方法自定义视图
/// 默认加载于‘[UIApplication sharedApplication].keyWindow’上
/// 位置为‘TYPopoverPositionTypeCenter’
/// 隐藏取消按钮
/// 点击背景视图取消视图
/// 自动响应‘Textfield’等输入事件并进行仿射变换,点击视图会取消响应链
+ (TYPopover *)showPopoverWithCustomView:(UIView *)popoverCustomView customRect:(CGRect)popoverCustomRect;

/// 类方法自定义视图
/// 实际内容如上,但是可以添加按钮
/// 点击背景视图不取消视图
+ (TYPopover *)showPopoverWithCustomView:(UIView *)popoverCustomView customRect:(CGRect)popoverCustomRect otherButtons:(NSArray *)otherButtons completeHandler:(TYPopoverHandler)handler;

/// 类方法
/// 默认加载于‘[UIApplication sharedApplication].keyWindow’上
/// 位置为‘TYPopoverPositionTypeCenter’
/// 点击背景视图取消视图
/// 控件的宽度为’屏幕宽度-40‘
/// 控件中按钮的高度为‘70’
/// 隐藏取消按钮
/// 只包含按钮
+ (TYPopover *)showPopoverWithButtons:(NSArray *)buttons completeHandler:(TYPopoverHandler)handler;

/// 类方法
/// 关闭弹框
+ (void)hiddenPopoverInView:(UIView *)inView;

@end





@interface UIColor(TYPopover)
/// 根据颜色获取相对应的图片
- (UIImage *)popoverColorImage;

@end
