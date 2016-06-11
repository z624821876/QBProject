//
//  BasicController.h
//  ULove
//
//  Created by TimothyYan on 16/3/24.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import "TYNavigationViewController.h"
#import "TYViewModel.h"

@interface TYViewController : TYNavigationViewController

/// 初始化模型
- (instancetype)initWithViewModel:(TYViewModel *)viewModel;

/// 绑定一些初始化值
/// 第一步
- (void)bindInitialization;

/// 添加子控件
/// 第二步
- (void)bindSubView;

/// 添加通知
/// 第三步
- (void)bindNotification;

/// 绑定模型
/// 第四步
- (void)bindViewModel;

@end
