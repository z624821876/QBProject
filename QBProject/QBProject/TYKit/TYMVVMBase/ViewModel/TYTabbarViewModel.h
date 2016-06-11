//
//  UETabbarViewModel.h
//  ULove
//
//  Created by TimothyYan on 16/3/27.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import "TYViewModel.h"

@interface TYTabbarViewModel : TYViewModel

/// 控制器
@property (nonatomic,strong) NSArray *viewControllers;

/// 跳转控制器的指令
@property (nonatomic,strong) RACCommand *viewControllerCommand;

/// 选中的第一个控制器
@property (nonatomic,strong) NSNumber *selectedIndex;

/// Entitys
@property (nonatomic,strong) NSArray *entitys;

@end
