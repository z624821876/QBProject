
//
//  UIButton+TYKit.m
//  ULove
//
//  Created by TimothyYan on 16/3/21.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import "UIButton+TYKit.h"

@implementation UIButton (TYKit)

+ (UIButton *)defaultButton {
    UIButton *defaultButton = [[UIButton alloc] init];
    defaultButton.titleLabel.font = [UIFont systemFontOfSize:16];
    defaultButton.layer.cornerRadius = 5;
    defaultButton.clipsToBounds = YES;
    return defaultButton;
}

@end
