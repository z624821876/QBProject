//
//  TYMasker.h
//  TYKit
//
//  Created by QuincyYan on 16/4/10.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    /// 只包含文字
    maskerTypeOnlyText = 0,
    /// 成功标志
    maskerTypeSuccess  = 1,
    /// 失败标志
    maskerTypeFail     = 2,
    /// 警示标志
    maskerTypeAlert    = 3,
    /// 等待标志
    maskerTypeWait     = 4,
    /// 有底部黑色半透明遮罩层,显示为‘等待标志’
    maskerTypeCover    = 5,
}TYMaskerType;

typedef void (^ TYMaskerFinishBlock)();

@interface TYMasker : UIView

/// 主视图
@property (nonatomic,strong) UIView *maskerView;

/// 头部提示视图
@property (nonatomic,strong) CAShapeLayer *maskerTopShapeLayer;

/// 内容视图
@property (nonatomic,strong) UILabel *maskerDetailLabel;

/// 等待框
@property (nonatomic,strong) UIActivityIndicatorView *activityView;

/// 控件显示的方式
@property (nonatomic,assign) TYMaskerType maskerType;

/// 定时器设置的时间
@property (nonatomic) NSTimeInterval autoHiddenTimeInterval;

/// 定时器完成后回调
@property (nonatomic,copy) TYMaskerFinishBlock completeBlock;

/// 显示视图
/// inView属性非必须,如果不传则默认添加于‘[UIApplication sharedApplication].keyWindiw‘上
- (void)showInView:(UIView *)inView;

/// 移除视图
- (void)hidden;




/// 显示遮罩层,遮罩层为全屏遮罩,无法点击
/// 不主动消失
+ (void)showMaskerWithCoverTypeContainsScripts:(NSString *)scripts showInView:(UIView *)inView;

/// 显示遮罩层,遮罩层为全屏遮罩,无法点击
/// 不主动消失
/// 有回调
+ (void)showMaskerWithCoverTypeContainsScripts:(NSString *)scripts showInView:(UIView *)inView TYMaskerFinishBlock:(TYMaskerFinishBlock)block;

/// 显示遮罩层
/// 会主动消失
/// 默认‘两秒’钟之后
+ (void)showMaskerWithType:(TYMaskerType)type scripts:(NSString *)scripts;

/// 显示遮罩层
/// 会主动消失
/// 默认‘两秒’钟之后
/// 需要添加到一个‘inView’上
+ (void)showMaskerWithType:(TYMaskerType)type scripts:(NSString *)scripts showInView:(UIView *)inView;

/// 显示遮罩层
/// 不主动消失,需要自己设置时间‘delayTime’
/// 有回调
+ (void)showMaskerWithType:(TYMaskerType)type scripts:(NSString *)scripts delayTimeInterval:(NSTimeInterval)delayTime TYMaskerFinishBlock:(TYMaskerFinishBlock)block;

/// 显示遮罩层
/// 不主动消失,需要自己设置时间‘delayTime’
/// 有回调
/// 需要添加到一个‘inView’上
+ (void)showMaskerWithType:(TYMaskerType)type scripts:(NSString *)scripts delayTimeInterval:(NSTimeInterval)delayTime showInView:(UIView *)inView TYMaskerFinishBlock:(TYMaskerFinishBlock)block;

/// 隐藏遮罩层
+ (void)hiddenMaskerInView:(UIView *)inView;

@end
