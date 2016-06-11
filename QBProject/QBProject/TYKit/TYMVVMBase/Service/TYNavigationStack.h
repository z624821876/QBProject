//
//  TYNavigationStack.h
//  ULove
//
//  Created by TimothyYan on 16/3/27.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TYNavigationStack : NSObject

- (instancetype)initWithService:(id<TYViewModelService>)service;

- (void)pushNavigationController:(UINavigationController *)navigationController;

- (UINavigationController *)popNavigationController;

- (UINavigationController *)topNavigationController;

@end
