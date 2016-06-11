//
//  UIView+TYKit.m
//  ULove
//
//  Created by TimothyYan on 16/3/21.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import "UIView+TYKit.h"
#import <objc/runtime.h>

@interface UIView()
@property (nonatomic,copy) gestureTapBlock gestureBlock;
@end

@implementation UIView (TYKit)
static char blockKey;

+ (UIView *)viewWithColor:(UIColor *)color {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = color;
    return view;
}

- (void)handleTapGestureWithBlock:(gestureTapBlock)block {
    self.gestureBlock = block;
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAction)];
    [self addGestureRecognizer:tapGesture];
}

- (void)gestureAction {
    if (self.gestureBlock) {
        self.gestureBlock();
    }
}

- (void)setGestureBlock:(gestureTapBlock)gestureBlock {
    objc_setAssociatedObject(self, &blockKey, gestureBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (gestureTapBlock)gestureBlock {
    return objc_getAssociatedObject(self, &blockKey);
}

- (void)cornerRadius:(CGFloat)radius width:(CGFloat)width color:(UIColor *)color {
    self.clipsToBounds = YES;
    self.layer.cornerRadius = radius;
    self.layer.borderWidth = width;
    if (color) {
        self.layer.borderColor = color.CGColor;
    }
}

- (void)removeAllSubviews {
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
}

- (void)removeAllSubviewsWithType:(Class)type {
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:type]) {
            [subView removeFromSuperview];
        }
    }
}

- (void)viewWithBackgroundImage:(UIImage *)backgroundImage withAlpha:(CGFloat)alpha {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:backgroundImage];
    [imageView setAlpha:alpha];
    [self addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)viewWithBackgroundImage:(UIImage *)backgroundImage {
    [self viewWithBackgroundImage:backgroundImage withAlpha:1.0f];
}

-(void)viewContainsTextFieldShouldAppear {
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[UITextField class]]) {
            [subView becomeFirstResponder];
            return;
        }
    }
}

-(void)viewInsertSplitIsContainsTop:(BOOL)top topPadding:(CGFloat)topPadding andBottom:(BOOL)bottom bottomPadding:(CGFloat)bottomPadding{
    if (top){
        UIView *topLine = [UIView viewWithColor:[UIColor colorWithHexString:@"d7d7d7"]];
        [self addSubview:topLine];
        
        [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.5);
            make.top.and.right.equalTo(self);
            make.left.equalTo(self).offset(topPadding);
        }];
    }
    if (bottom){
        UIView *bottomLine = [UIView viewWithColor:[UIColor colorWithHexString:@"d7d7d7"]];
        [self addSubview:bottomLine];
        
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.5);
            make.right.and.bottom.equalTo(self);
            make.left.equalTo(self).offset(bottomPadding);
        }];
    }
}

- (CGFloat)width {
    return self.frame.size.width;
}

-(CGFloat)height{
    return self.frame.size.height;
}

-(CGFloat)x{
    return self.frame.origin.x;
}

-(CGFloat)y{
    return self.frame.origin.y;
}

@end
