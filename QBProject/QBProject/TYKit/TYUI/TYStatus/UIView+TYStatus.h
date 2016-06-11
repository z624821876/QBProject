//
//  UIView+TYStatus.h
//  ULove
//
//  Created by TimothyYan on 16/3/21.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TYStatusView;
@class TYLoadingView;
typedef NS_ENUM(NSInteger , TYStatusStyle) {
    /// 加载失败
    TYStatusStyleFail = 0,
    /// 无数据
    TYStatusStyleEmptyData = 1,
    /// 网络异常
    TYStatusStyleNetworkError = 2,
};

typedef void (^ TYStatusResponseHandler)();

@interface UIView (TYStatus)

/// 展示一个状态图
/// 点击整个视图都可以响应‘handler’事件
- (void)showStatusWithStyle:(TYStatusStyle)style responseHandler:(TYStatusResponseHandler)handler;

/// 展示视图
- (void)showStatusWithImage:(NSString *)image description:(NSString *)desc responseHandler:(TYStatusResponseHandler)handler;

/// 视图
@property (nonatomic,strong) TYStatusView *statusView;

/// 响应
@property (nonatomic,copy) TYStatusResponseHandler handler;

/// 加载视图
@property (nonatomic,strong) TYLoadingView  *loadingView;

/// 开始
- (void)startLoading;

/// 结束
- (void)stopLoading;


@end





@interface TYStatusView : UIButton

/// 图片
@property (nonatomic,strong) UIImageView *iconImageView;

/// 提示文字
@property (nonatomic,strong) UILabel *textLabel;

@end




@interface TYLoadingView : UIView

/// 开始
- (void)startLoading;

/// 结束
- (void)stopLoading;

@end