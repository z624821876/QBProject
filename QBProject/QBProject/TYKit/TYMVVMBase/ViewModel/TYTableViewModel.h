//
//  UETableViewModel.h
//  ULove
//
//  Created by TimothyYan on 16/3/26.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import "TYViewModel.h"

@interface TYTableViewModel : TYViewModel

/// 当前的页面
@property (nonatomic) NSInteger page;

/// 数据源
@property (nonatomic,strong) NSArray *dataSource;

/// 是否可以下拉加载
@property (nonatomic,assign) BOOL shouldPullToRefresh;

/// 是否可以上拉加载更多
@property (nonatomic,assign) BOOL shouldLoadRest;

/// 获取更多数据指令
@property (nonatomic,strong) RACCommand *requestRemoteDataCommand;

/// 选中指令
@property (nonatomic,strong) RACCommand *didSelectedCommand;

/// 拉取数据
- (RACSignal *)requestRemoteDataFromPage:(NSUInteger)page;

/// 处理结果数据
- (void)handleWithDataSource:(NSArray *)dataSource;

@end
