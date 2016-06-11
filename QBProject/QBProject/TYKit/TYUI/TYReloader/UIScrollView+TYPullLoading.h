//
//  UIScrollView+TYPullLoading.h
//  TYKit
//
//  Created by QuincyYan on 16/4/21.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYPullLoadingView.h"

/// 上拉加载
@interface UIScrollView (TYPullLoading)

/// 添加一个上拉加载控件
- (void)addPullLoadingWithHandler:(void (^)())handler;

/// 加载控件
@property (nonatomic,strong) TYPullLoadingView *pullLoadingView;

@end