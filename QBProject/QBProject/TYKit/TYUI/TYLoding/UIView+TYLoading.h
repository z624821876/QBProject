//
//  UIView+TYLoading.h
//  UEProject
//
//  Created by QuincyYan on 16/5/11.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TYLodingView;
@interface UIView (TYLoading)

/// 开始动画
- (void)startLoading;

/// 结束动画
- (void)stopLoading;

/// 视图
@property (nonatomic,strong) TYLodingView *loadingView;

@end




@interface TYLodingView : UIView

/// 开始动画
- (void)startLoading;

/// 结束动画
- (void)stopLoading;

@end
