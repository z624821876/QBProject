//
//  TYRequestService.m
//  MPProject
//
//  Created by QuincyYan on 16/5/27.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import "TYRequestService.h"
#import <AFNetworking.h>

@implementation TYRequestService

+ (TYRequestService *)sharedRequester {
    static TYRequestService *requester = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        requester = [[TYRequestService alloc] init];
    });
    return requester;
}

- (RACSignal *)requesterWithURL:(NSString *)requestURL requestParams:(NSDictionary *)requestParams {
    if (!requestParams) {
        requestParams = [[NSDictionary alloc] init];
    }
    return [self requesterWithURL:requestURL requestParams:[requestParams encrypt] HTTPHeaderFields:[self defaultHTTPHeaderFields] timeoutInterval:15];
}

- (RACSignal *)submitImageWithURL:(NSString *)requestURL imageList:(NSArray *)imageList imageFileName:(NSString *)imageFileName {
    return [self submitImageWithURL:requestURL imageList:imageList imageFileName:imageFileName params:[[[NSDictionary alloc] init] encrypt] HTTPHeaderFields:[self defaultHTTPHeaderFields] timeoutInterval:30];
}

/// 处理返回结果
- (void)handleWithResponseObject:(id)responseObject
                   responseError:(NSError *)error
                      subscriber:(id<RACSubscriber>)subscriber
                   requestParams:(NSDictionary *)requestParams
                       URLString:(NSURL *)URLString {
    if (responseObject) {
        NSLog(@"\n\n\n请求成功:\n%@\n请求的参数:\n%@\n请求的地址:\n%@\n",responseObject,requestParams,URLString.absoluteString);
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 200) {
            id data = responseObject[@"data"];
            if (![data isKindOfClass:[NSNull class]]) {
                [subscriber sendNext:data];
            }
        }else {
            NSLog(@"\n服务器返回错误信息:\n%@\n",responseObject[@"msg"]);
            NSError *analyError = [NSError errorWithDomain:serverURL() code:[responseObject[@"code"] integerValue] userInfo:responseObject];
            [subscriber sendError:analyError];
        }
    }else if (error){
        NSLog(@"\n\n\n请求失败:\n%@\n请求的参数:\n%@\n请求的地址:\n%@\n",error,requestParams,URLString.absoluteString);
        [subscriber sendError:error];
    }else {
        NSLog(@"\n\n\n返回数据为空:\n%@\n请求的参数:\n%@\n请求的地址:\n%@\n",error,requestParams,URLString.absoluteString);
        NSError *analyError = [NSError errorWithDomain:serverURL() code:[responseObject[@"code"] integerValue] userInfo:responseObject];
        [subscriber sendError:analyError];
    }
    [subscriber sendCompleted];
}

/// 添加请求头
- (NSDictionary *)defaultHTTPHeaderFields {
    NSMutableDictionary *HTTPHeaderFields = [[NSMutableDictionary alloc] init];
//    [HTTPHeaderFields setObject:@"1" forKey:@"tag"];
//    [HTTPHeaderFields setObject:[UIDevice currentDevice].identifierForVendor.UUIDString forKey:@"deviceId"];
//    if ([MMUserModel isUserLogin].boolValue) {
//        [HTTPHeaderFields setObject:[MMUserModel currUser].userId forKey:@"userId"];
//        [HTTPHeaderFields setObject:[MMUserModel currUser].token forKey:@"token"];
//    }
    return HTTPHeaderFields;
}

/// 生成请求Manager
- (void)managerWithRequestURL:(NSString *)requestURL
             HTTPHeaderFields:(NSDictionary *)HTTPHeaderFields
              timeoutInterval:(NSTimeInterval)timeoutInterval
                        block:(void (^ )(AFURLSessionManager *manager, AFHTTPRequestSerializer *request))block{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    response.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
    manager.responseSerializer = response;
    
    AFHTTPRequestSerializer *request = [AFHTTPRequestSerializer serializer];
    request.timeoutInterval = timeoutInterval;
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:requestURL forHTTPHeaderField:@"Referer"];
    if (HTTPHeaderFields && [HTTPHeaderFields allKeys].count > 0) {
        for (NSString *key in [HTTPHeaderFields allKeys]) {
            [request setValue:HTTPHeaderFields[key] forHTTPHeaderField:key];
        }
    }
    block (manager,request);
}

- (RACSignal *)requesterWithURL:(NSString *)requestURL requestParams:(NSDictionary *)requestParams HTTPHeaderFields:(NSDictionary *)HTTPHeaderFields timeoutInterval:(NSTimeInterval)timeoutInterval{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self managerWithRequestURL:requestURL HTTPHeaderFields:HTTPHeaderFields timeoutInterval:timeoutInterval block:^(AFURLSessionManager *manager, AFHTTPRequestSerializer *request) {
            NSError *requestError;
            NSURL *URLString = [NSURL URLWithString:requestURL relativeToURL:[NSURL URLWithString:serverURL()]];
            NSMutableURLRequest *mutableRequest = [request requestWithMethod:@"POST"
                                                                   URLString:URLString.absoluteString
                                                                  parameters:requestParams
                                                                       error:&requestError];
            
            NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:mutableRequest
                                                        completionHandler:^(NSURLResponse * response, id responseObject, NSError * error) {
                                                            [self handleWithResponseObject:responseObject responseError:error subscriber:subscriber requestParams:requestParams URLString:URLString];
                                                        }];
            [dataTask resume];
        }];
        return nil;
    }];
}

- (RACSignal *)submitImageWithURL:(NSString *)requestURL imageList:(NSArray *)imageList imageFileName:(NSString *)imageFileName params:(NSDictionary *)params HTTPHeaderFields:(NSDictionary *)HTTPHeaderFields timeoutInterval:(NSTimeInterval)timeoutInterval{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self managerWithRequestURL:requestURL HTTPHeaderFields:HTTPHeaderFields timeoutInterval:timeoutInterval block:^(AFURLSessionManager *manager, AFHTTPRequestSerializer *request) {
            NSURL *URLString = [NSURL URLWithString:requestURL relativeToURL:[NSURL URLWithString:serverURL()]];
            NSMutableURLRequest *mutableRequest = [request multipartFormRequestWithMethod:@"POST"
                                                                                URLString:URLString.absoluteString
                                                                               parameters:params
                                                                constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                                                                    for (UIImage *image in imageList) {
                                                                        NSData *data = UIImageJPEGRepresentation(image, 1.0);
                                                                        [formData appendPartWithFileData:data name:imageFileName fileName:[NSString stringWithFormat:@"%@.png",image] mimeType:@"image/png"];
                                                                    }
                                                                } error:nil];
            
            NSURLSessionUploadTask *dataTask = [manager uploadTaskWithStreamedRequest:mutableRequest
                                                                             progress:^(NSProgress * _Nonnull uploadProgress) {
                                                                                 
                                                                             } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                                                                 [self handleWithResponseObject:responseObject responseError:error subscriber:subscriber requestParams:params URLString:URLString];
                                                                             }];
            [dataTask resume];
        }];
        return nil;
    }];
}


@end
