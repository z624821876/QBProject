//
//  MPErrorService.h
//  MPProject
//
//  Created by QuincyYan on 16/6/6.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QBErrorService : NSObject

/// 显示错误提示
+ (void)errorHandlerWithError:(NSError *)error showInView:(UIView *)inView;

@end
