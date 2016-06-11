//
//  MPRequestService.m
//  MPProject
//
//  Created by QuincyYan on 16/6/6.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import "QBRequestService.h"
#import "TYRequestService.h"

@implementation QBRequestService

+ (QBRequestService *)sharedService {
    static QBRequestService *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[QBRequestService alloc] init];
    });
    return sharedInstance;
}

- (RACSignal *)requestProductDetailsWithPage:(NSInteger)page {
    return [[TYRequestService sharedRequester] requesterWithURL:@"product/products" requestParams:@{@"page":@(page)}];
}

- (RACSignal *)requestProductTradesWithProductId:(NSNumber *)productId page:(NSInteger)page {
    return [[TYRequestService sharedRequester] requesterWithURL:@"product/trades" requestParams:@{@"productid":productId}];
}

- (RACSignal *)submitProductWithParams:(NSDictionary *)params {
    return [[TYRequestService sharedRequester] requesterWithURL:@"product/addProduct" requestParams:params];
}

- (RACSignal *)submitProductTradeWithParams:(NSDictionary *)params {
    return [[TYRequestService sharedRequester] requesterWithURL:@"product/addTrade" requestParams:params];
}

- (RACSignal *)requestClientsWithPage:(NSInteger)page {
    return [[TYRequestService sharedRequester] requesterWithURL:@"client/clients" requestParams:@{@"page":@(page)}];
}

- (RACSignal *)submitClientWithParams:(NSDictionary *)params {
    return [[TYRequestService sharedRequester] requesterWithURL:@"client/addClient" requestParams:params];
}

- (RACSignal *)requestClientOrdersWithClientId:(NSNumber *)clientId page:(NSInteger)page {
    return [[TYRequestService sharedRequester] requesterWithURL:@"client/clientOrders" requestParams:@{@"customerid":clientId}];
}

- (RACSignal *)requestChargesWithPage:(NSInteger)page {
    return [[TYRequestService sharedRequester] requesterWithURL:@"charge/charges" requestParams:@{@"page":@(page)}];
}

- (RACSignal *)submitChargeWithParams:(NSDictionary *)params {
    return [[TYRequestService sharedRequester] requesterWithURL:@"charge/addCharge" requestParams:params];
}

- (RACSignal *)submitClientOrderWithParams:(NSDictionary *)params {
    return [[TYRequestService sharedRequester] requesterWithURL:@"client/addClientOrder" requestParams:params];
}

@end
