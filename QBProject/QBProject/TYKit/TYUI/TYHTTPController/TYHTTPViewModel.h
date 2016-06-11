//
//  TYHTTPViewModel.h
//  UEProject
//
//  Created by QuincyYan on 16/5/10.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import "TYViewModel.h"

@interface TYHTTPViewModel : TYViewModel

/// 跳转的地址
@property (nonatomic,copy) NSString *URL;

/// 初始化方法
- (instancetype)initWithService:(id<TYViewModelService>)service pushURL:(NSString *)URL;

@end
