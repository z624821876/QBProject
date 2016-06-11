//
//  TYBasicView.h
//  ULove
//
//  Created by TimothyYan on 16/3/29.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TYView : UIView

/// 初始化模型
- (instancetype)initWithViewModel:(TYViewModel *)viewModel;

/// 绑定模型
/// 在初始化后调用
- (void)bindViewModel;

@end
