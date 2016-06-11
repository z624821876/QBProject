//
//  TYRequestService.h
//  MPProject
//
//  Created by QuincyYan on 16/5/27.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TYRequestService : NSObject

/// 单例
+ (TYRequestService *)sharedRequester;

/// 请求方式
/// 不进行任何加密
- (RACSignal *)requesterWithURL:(NSString *)requestURL requestParams:(NSDictionary *)requestParams HTTPHeaderFields:(NSDictionary *)HTTPHeaderFields timeoutInterval:(NSTimeInterval)timeoutInterval;

/// 请求方式
/// 上传数据
- (RACSignal *)submitImageWithURL:(NSString *)requestURL imageList:(NSArray *)imageList imageFileName:(NSString *)imageFileName params:(NSDictionary *)params HTTPHeaderFields:(NSDictionary *)HTTPHeaderFields timeoutInterval:(NSTimeInterval)timeoutInterval;

/// 请求方式
/// 请求头为默认
/// 请求超时时间为十五秒
/// 对参数进行加密
- (RACSignal *)requesterWithURL:(NSString *)requestURL requestParams:(NSDictionary *)requestParams;

/// 上传数据
/// 请求头为默认
/// 请求超时时间为30秒
/// 对参数进行加密
- (RACSignal *)submitImageWithURL:(NSString *)requestURL imageList:(NSArray *)imageList imageFileName:(NSString *)imageFileName;

@end
