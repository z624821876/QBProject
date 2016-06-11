//
//  TYBindViewModel.h
//  ULove
//
//  Created by TimothyYan on 16/4/1.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TYViewModel;
@protocol TYBindViewModel <NSObject>

/// 绑定模型
-(void)bindViewModel:(id)viewModel;

@end
