//
//  TYPullLoadingView.h
//  TYKit
//
//  Created by QuincyYan on 16/5/31.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    /// 最初的状态
    TYPullLoadingStateOriginal = 0,
    /// 下拉的状态
    TYPullLoadingStatePulling = 1,
    /// 刷新中的状态
    TYPullLoadingStateLoading = 2,
} TYPullLoadingState;

@interface TYPullLoadingView : UIView

/// 状态
@property (nonatomic,assign,readonly) TYPullLoadingState pullLoadingState;

/// 滚动视图
@property (nonatomic,strong) UIScrollView *scrollView;

/// 原始的内边距
@property (nonatomic,assign) UIEdgeInsets originalEdgeInsets;

/// 刷新时候的回调
@property (nonatomic,copy) void (^ pullLoadingHandler)();

/// 停止加载
- (void)stopPullLoading;

/// 主动加载
- (void)startPullLoading;

@end
