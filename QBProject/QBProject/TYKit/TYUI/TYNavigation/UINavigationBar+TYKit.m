//
//  UINavigationBar+TYKit.m
//  TYKit
//
//  Created by TimothyYan on 16/2/17.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import "UINavigationBar+TYKit.h"
#import <objc/runtime.h>

@interface UINavigationBar()
@property (nonatomic,strong) UIImageView *barView;

@end

@implementation UINavigationBar (TYKit)
static char barViewKey;

-(UIColor *)ty_barTintColor{
    return self.barView.backgroundColor;
}

-(void)ty_modifyBarColor:(UIColor *)barColor{
    self.barView.backgroundColor = barColor;
}

-(void)ty_modifyBarColorWithAlpha:(CGFloat)alpha{
    self.barView.alpha = alpha;
}

-(void)ty_modifyBarBackgroundImage:(UIImage *)backgroundImage{
    self.barView.image = backgroundImage;
}

-(UIImageView *)barView{
    UIImageView *barView = objc_getAssociatedObject(self, &barViewKey);
    if (!barView) {
        self.barView = [[UIImageView alloc] init];
        self.barView.frame = CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, CGRectGetHeight(self.bounds) + 20);
        self.barView.backgroundColor = [UIColor whiteColor];
        self.barView.userInteractionEnabled = NO;
        [self insertSubview:self.barView atIndex:0];
        
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        
        barView = self.barView;
    }
    return barView;
}

-(void)setBarView:(UIView *)barView{
    objc_setAssociatedObject(self, &barViewKey, barView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

