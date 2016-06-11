//
//  TYRouter.m
//  ULove
//
//  Created by TimothyYan on 16/3/26.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import "TYRouter.h"

@implementation TYRouter

+ (instancetype)sharedRouter{
    static TYRouter *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[TYRouter alloc] init];
    });
    return sharedInstance;
}

- (TYViewController *)viewControllerWithViewModel:(TYViewModel *)viewModel{
    NSString *viewController = viewModelMapping()[NSStringFromClass([viewModel class])];
    return [[NSClassFromString(viewController) alloc] initWithViewModel:viewModel];
}

- (TYNaviController *)navigationControllerWithViewModel:(TYViewModel *)viewModel {
    return [[TYNaviController alloc] initWithRootViewController:[self viewControllerWithViewModel:viewModel]];
}

@end
