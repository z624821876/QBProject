//
//  TYNavigation.m
//  TYKit
//
//  Created by TimothyYan on 16/2/17.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import "TYNavigation.h"
#import "UIColor+TYKit.h"
#import <objc/runtime.h>

@interface TYNavigation()

@end

@implementation TYNavigation{
    UINavigationBar *_navigationBar;
    
    UIColor *_originalTintColor, *_originalTitleColor, *_originalBarColor;
    NSDictionary *_originalTitleAtt;
    UIImage *_originalShadowImage;
    UIStatusBarStyle _originalStatusBarStyle;
}

-(instancetype)initWithNavigationBar:(UINavigationBar *)navigationBar{
    if (self = [super init]) {
        _navigationBar = navigationBar;
        
        _originalBarColor = navigationBar.ty_barTintColor;
        _originalTintColor = navigationBar.tintColor;
        _originalTitleAtt = navigationBar.titleTextAttributes;
        _originalTitleColor = navigationBar.titleTextAttributes[NSForegroundColorAttributeName];
        _originalShadowImage = navigationBar.shadowImage;
        _originalStatusBarStyle = [UIApplication sharedApplication].statusBarStyle;
        
        _shadowImage = [UIImage imageNamed:@""];
        _tintColor = [UIColor whiteColor];
        _backgroundColor = [UIColor whiteColor];
        _titleArrtibute = [[NSMutableDictionary alloc] init];
        _backgroundColor = [UIColor whiteColor];
        _barColorAlpha = 1.0f;
        _isHiddenNavigationBar = NO;
    }
    return self;
}

-(void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    [_titleArrtibute setValue:titleColor forKey:NSForegroundColorAttributeName];
}

-(void)setBarColorAlpha:(CGFloat)barColorAlpha{
    _barColorAlpha = barColorAlpha;
    [_navigationBar ty_modifyBarColorWithAlpha:barColorAlpha];
}

-(void)ty_viewWillAppear{
    _navigationBar.shadowImage = self.shadowImage;
    _navigationBar.tintColor = self.tintColor;
    _navigationBar.titleTextAttributes = self.titleArrtibute;
    [_navigationBar ty_modifyBarColor:self.backgroundColor];
    [_navigationBar setHidden:_isHiddenNavigationBar];
    [[UIApplication sharedApplication] setStatusBarStyle:self.statusBarStyle];
}

-(void)ty_viewWillDisappear{
    _navigationBar.shadowImage = _originalShadowImage;
    _navigationBar.tintColor = _originalTintColor;
    _navigationBar.titleTextAttributes = _originalTitleAtt;
    [_navigationBar ty_modifyBarColor:_originalBarColor];
    [_navigationBar setHidden:_isHiddenNavigationBar];
    [[UIApplication sharedApplication] setStatusBarStyle:_originalStatusBarStyle];
}

@end