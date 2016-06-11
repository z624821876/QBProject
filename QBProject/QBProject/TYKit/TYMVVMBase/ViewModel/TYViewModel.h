//
//  UEViewModel.h
//  ULove
//
//  Created by TimothyYan on 16/3/26.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TYViewModelService.h"

@interface TYViewModel : NSObject

///初始化
- (instancetype)initWithService:(id<TYViewModelService>)service params:(NSDictionary *)params;

/// 初始化后调用的函数
- (void)initialize;

/// 服务
/// 跳转页面、返回页面等逻辑处理
@property (nonatomic,strong) id<TYViewModelService> service;

/// 自定义的参数
@property (nonatomic,strong) NSDictionary *params;

/// 是否一开始需要加载数据
@property (nonatomic,assign) BOOL shouldLoadDataInitially;

/// 是否有上拉加载更多
@property (nonatomic,assign) BOOL shouldInfiniteScrolling;

/// 控制器标题
@property (nonatomic,copy) NSString *title;

/// 左侧按钮是否显示返回图片
/// 默认为‘否’(即显示返回箭头图标)
@property (nonatomic) BOOL isHiddenBackBarButton;

/// 标题类
/// 如果子集是TYBarButtonEntity的,则显示相关属性
/// 如果子集是NSString类的,则默认显示为字体大小为17的只含有标题的按钮

/// 左侧导航栏
/// 如果isHiddenLeftBarButton为‘NO’,则默认添加一个返回按钮
@property (nonatomic,strong) NSArray *leftBarButtons;

/// 左侧按钮点击指令
@property (nonatomic,strong) RACCommand *leftBarCommand;

/// 右侧按钮标题
@property (nonatomic,strong) NSArray *rightBarButtons;

/// 右侧按钮点击指令
@property (nonatomic,strong) RACCommand *rightBarCommand;

/// 返回按钮点击指令
@property (nonatomic,strong) RACCommand *backBarCommand;


@end