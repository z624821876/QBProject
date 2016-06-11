//
//  NSDictionary+Encrypt.h
//  MagicMask
//
//  Created by yanyibin on 16/4/7.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Encrypt)

/// 进行加密
// 巨一享连专属加密
// 采用RSA加密方式
// 先添加randomType、appVersion、deviceName、deviceType的键值对
// 然后对参数值中的所有Key进行排序,例如 A B C D..,并生成一个键值对,例如 a=file&b=edit&c=view ....
// 如果用户是登录的,则添加userid
// 然后添加serverPublicKey并进行MD5加密并且小写
// 然后这个作为参数添加到请求的参数里面
- (NSDictionary *)encrypt;

/// 加密类方法,主要用于传空字典
+ (NSDictionary *)encryptEmpty;

@end
