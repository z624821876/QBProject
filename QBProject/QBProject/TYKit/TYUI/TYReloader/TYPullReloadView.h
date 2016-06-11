//
//  TYPullReloadView.h
//  TYKit
//
//  Created by QuincyYan on 16/5/31.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    /// 初始状态
    TYPullReloadStateOriginal = 0,
    /// 下拉刷新等待释放
    TYPullReloadStateWillRelease = 1,
    /// 刷新中
    TYPullReloadStateReloading = 2
}TYPullReloadState;

@interface TYPullReloadView : UIView

/// 控件当前状态
@property (nonatomic) TYPullReloadState pullReloadState;

/// 滚动视图
@property (nonatomic,strong) UIScrollView *scrollView;

/// 原始的内边距
@property (nonatomic) UIEdgeInsets originalEdgeInsets;

/// 回调
@property (nonatomic,copy) void (^ pullReloadHandler)();

/// 停止刷新
- (void)stopPullReloading;

/// 自主刷新
- (void)startPullReloading;

@end
