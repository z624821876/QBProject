//
//  QBUserModel.m
//  QBProject
//
//  Created by QuincyYan on 16/6/13.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "QBUserModel.h"

static NSString *const userLoginKey = @"QB_UserLoginKey";
static NSString *const userDataKey = @"QB_UserDataKey";

@implementation QBUserModel

+ (QBUserModel *)currUser{
    QBUserModel *userModel = [QBUserModel yy_modelWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:userDataKey]];
    return userModel;
}

+ (NSNumber *)isUserLogin{
    return [[NSUserDefaults standardUserDefaults] objectForKey:userLoginKey];
}

+ (void)insertUserData:(NSDictionary *)data{
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:userDataKey];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:userLoginKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"userLoginNotify" object:nil];
}

+ (void)userLogout{
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:userDataKey];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:NO] forKey:userLoginKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"userLogoutNotify" object:nil];
}

@end
