//
//  TYRouter.h
//  ULove
//
//  Created by TimothyYan on 16/3/26.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TYViewController.h"
#import "TYViewModel.h"
#import "TYNaviController.h"

@interface TYRouter : NSObject

/// 单例
+ (instancetype)sharedRouter;

/// 根据ViewModel返回相应的控制器
- (TYViewController *)viewControllerWithViewModel:(TYViewModel *)viewModel;

/// 根据ViewModel返回对应的导航控制器
- (TYNaviController *)navigationControllerWithViewModel:(TYViewModel *)viewModel;

@end
