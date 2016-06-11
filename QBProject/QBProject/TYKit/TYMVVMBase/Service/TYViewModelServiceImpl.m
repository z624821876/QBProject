//
//  UEViewModelServiceImpl.m
//  ULove
//
//  Created by TimothyYan on 16/3/27.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import "TYViewModelServiceImpl.h"

@implementation TYViewModelServiceImpl

- (void)pushViewModel:(TYViewModel *)viewModel animated:(BOOL)animated{}

- (void)popViewModelAnimated:(BOOL)animated{}

- (void)popToRootViewModelAnimated:(BOOL)animated{}

- (void)presentViewModel:(TYViewModel *)viewModel animated:(BOOL)animated completion:(tyVoidBlock)completion{}

- (void)dismissViewModelAnimated:(BOOL)animated completion:(tyVoidBlock)completion{}

- (void)resetRootViewModel:(TYViewModel *)viewModel{}

@end
