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


@end
