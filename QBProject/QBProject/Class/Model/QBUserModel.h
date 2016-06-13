//
//  QBUserModel.h
//  QBProject
//
//  Created by QuincyYan on 16/6/13.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QBUserModel : NSObject

@property (nonatomic,strong) NSNumber *user_id, *gender, *record_time;
@property (nonatomic,copy) NSString *name, *avator, *address, *username, *password, *telephone;
@property (nonatomic,copy) NSString *repassword;

/// 获取用户信息
+ (QBUserModel *)currUser;

/// 用户是否登录
+ (NSNumber *)isUserLogin;

/// 存储用户登录信息
+ (void)insertUserData:(NSDictionary *)data;

/// 用户退出
+ (void)userLogout;

@end
