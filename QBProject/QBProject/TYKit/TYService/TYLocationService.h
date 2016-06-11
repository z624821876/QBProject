//
//  TYLocationService.h
//  MPProject
//
//  Created by QuincyYan on 16/5/27.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ serviceSearchedBlock)(NSString *city);

@interface TYLocationService : NSObject

/// 获取位置信息
-(void)startServiceWithBlock:(serviceSearchedBlock)block;

/// 验证用户是否禁止了定位服务
-(void)verifyUserLocationState;

@end
