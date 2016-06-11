//
//  UIScrollView+TYPullReload.h
//  TYKit
//
//  Created by QuincyYan on 16/4/21.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYPullReloadView.h"

/// 下拉刷新控件
@interface UIScrollView (TYPullReload)

/// 添加一个下拉刷新的控件
- (void)addPullReloadWithHandler:(void (^)())handler;

/// 控件
@property (nonatomic,strong) TYPullReloadView *pullReloadView;

@end
