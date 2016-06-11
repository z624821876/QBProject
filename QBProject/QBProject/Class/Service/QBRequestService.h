//
//  MPRequestService.h
//  MPProject
//
//  Created by QuincyYan on 16/6/6.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QBRequestService : NSObject

/// 单例
+ (QBRequestService *)sharedService;

/// 获取产品
- (RACSignal *)requestProductDetailsWithPage:(NSInteger)page;

/// 根据产品ID 获取订单列表
- (RACSignal *)requestProductTradesWithProductId:(NSNumber *)productId page:(NSInteger)page;

/// 提交一个产品
- (RACSignal *)submitProductWithParams:(NSDictionary *)params;

/// 获取客商列表
- (RACSignal *)requestClientsWithPage:(NSInteger)page;

/// 创建一个新的客商
- (RACSignal *)submitClientWithParams:(NSDictionary *)params;

/// 获取该客商的订单列表
- (RACSignal *)requestClientOrdersWithClientId:(NSNumber *)clientId page:(NSInteger)page;

/// 获取收支的进账
- (RACSignal *)requestChargesWithPage:(NSInteger)page;

/// 提交一个记账单
- (RACSignal *)submitChargeWithParams:(NSDictionary *)params;

/// 提交一个明细账
- (RACSignal *)submitProductTradeWithParams:(NSDictionary *)params;

/// 提交一个客商订单
- (RACSignal *)submitClientOrderWithParams:(NSDictionary *)params;

@end
