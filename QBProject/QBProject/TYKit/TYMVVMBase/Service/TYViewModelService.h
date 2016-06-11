//
//  TYViewModelService.h
//  ULove
//
//  Created by TimothyYan on 16/3/28.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ tyVoidBlock)();

@class TYViewModel;
@protocol TYViewModelService <NSObject>

/// 跳转一个控制器
- (void)pushViewModel:(TYViewModel *)viewModel animated:(BOOL)animated;

/// 切回一个控制器
- (void)popViewModelAnimated:(BOOL)animated;

/// 切回至根视图
- (void)popToRootViewModelAnimated:(BOOL)animated;

/// 呈现一个视图
- (void)presentViewModel:(TYViewModel *)viewModel animated:(BOOL)animated completion:(tyVoidBlock)completion;

/// 取消一个视图
- (void)dismissViewModelAnimated:(BOOL)animated completion:(tyVoidBlock)completion;

/// 重新设置一个根视图
- (void)resetRootViewModel:(TYViewModel *)viewModel;

@end
