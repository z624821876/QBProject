//
//  MPErrorService.m
//  MPProject
//
//  Created by QuincyYan on 16/6/6.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import "QBErrorService.h"

@implementation QBErrorService

+ (void)errorHandlerWithError:(NSError *)error showInView:(UIView *)inView {
    NSInteger code = error.code;
    if (code == -1001 || code == -1003 || code == -1009) {
        [TYMasker showMaskerWithType:maskerTypeAlert scripts:@"网络无法连接" showInView:inView];
    }else {
        NSString *msg = error.userInfo[@"msg"];
        if (!msg || msg.length == 0) {
            msg = error.localizedDescription;
        }
        [TYMasker showMaskerWithType:maskerTypeAlert scripts:msg showInView:inView];
    }
}

@end
