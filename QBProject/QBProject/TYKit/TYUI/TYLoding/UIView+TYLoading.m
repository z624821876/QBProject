//
//  UIView+TYLoading.m
//  UEProject
//
//  Created by QuincyYan on 16/5/11.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import "UIView+TYLoading.h"
#import <objc/runtime.h>

@implementation UIView (TYLoading)
static char TYLoadingKey;

- (void)startLoading {
    if (!self.loadingView) {
        self.loadingView = [[TYLodingView alloc] init];
    }
    
    [self addSubview:self.loadingView];
    self.loadingView.frame = self.bounds;
    
    [self.loadingView startLoading];
}

- (void)stopLoading {
    if (self.loadingView) {
        [self.loadingView stopLoading];
    }
}

- (void)setLoadingView:(TYLodingView *)loadingView {
    objc_setAssociatedObject(self, &TYLoadingKey, loadingView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (TYLodingView *)loadingView {
    return objc_getAssociatedObject(self, &TYLoadingKey);
}

@end




@interface TYLodingView()
/// 婴儿的头
@property (nonatomic,strong) UIImageView *babyHeadView;

/// 婴儿的眼睛
@property (nonatomic,strong) UIImageView *babyLeftEyeView;
@property (nonatomic,strong) UIImageView *babyRightEyeView;

/// 旁边的箭头
@property (nonatomic,strong) UIImageView *badyPlaneView;

/// 定时器
@property (nonatomic,strong) CADisplayLink *displayLink;

@end

@implementation TYLodingView{
    int _frames;
}

- (instancetype)init {
    if (self != [super init]) {
        return nil;
    }
    [self setBackgroundColor:[UIColor whiteColor]];
    
    [self addSubview:self.babyHeadView];
    [self addSubview:self.babyLeftEyeView];
    [self addSubview:self.babyRightEyeView];
    [self addSubview:self.badyPlaneView];
    
    [self.babyHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    [self.badyPlaneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(140, 140));
        make.center.equalTo(self);
    }];
    
    [self.babyLeftEyeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self).offset(-12);
        make.centerY.equalTo(self).offset(-15);
        make.size.mas_equalTo(CGSizeMake(6, 6));
    }];
    
    [self.babyRightEyeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self).offset(13);
        make.centerY.equalTo(self).offset(-15);
        make.size.mas_equalTo(CGSizeMake(6, 6));
    }];
    return self;
}

- (void)startLoading {
    if (self.displayLink) {
        [self.displayLink invalidate]; self.displayLink = nil;
    }
    
    _frames = 0;
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(TYLoadingHandler)];
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)TYLoadingHandler {
    _frames ++;
    
    CGFloat rotation = M_PI * 2 * ((CGFloat)_frames / (60 * 4));
    self.badyPlaneView.transform = CGAffineTransformMakeRotation(rotation);
    self.babyLeftEyeView.transform = CGAffineTransformMakeRotation(rotation);
    self.babyRightEyeView.transform = CGAffineTransformMakeRotation(rotation);
}

- (void)stopLoading {
    [self.displayLink invalidate]; self.displayLink = nil;
    _frames = 0;
    [self removeFromSuperview];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (self.displayLink) {
        [self.displayLink invalidate]; self.displayLink = nil;
    }
}

- (UIImageView *)babyHeadView {
    if (!_babyHeadView) {
        _babyHeadView = [[UIImageView alloc] init];
        _babyHeadView.image = [UIImage imageNamed:@"tyloding_baby_face"];
        _babyHeadView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _babyHeadView;
}

- (UIImageView *)babyLeftEyeView {
    if (!_babyLeftEyeView) {
        _babyLeftEyeView = [[UIImageView alloc] init];
        _babyLeftEyeView.image = [UIImage imageNamed:@"tyloding_baby_eye"];
        _babyLeftEyeView.contentMode = UIViewContentModeScaleAspectFit;
        _babyLeftEyeView.layer.anchorPoint = CGPointMake(0.5, 1);
    }
    return _babyLeftEyeView;
}

- (UIImageView *)babyRightEyeView {
    if (!_babyRightEyeView) {
        _babyRightEyeView = [[UIImageView alloc] init];
        _babyRightEyeView.image = [UIImage imageNamed:@"tyloding_baby_eye"];
        _babyRightEyeView.contentMode = UIViewContentModeScaleAspectFit;
        _babyRightEyeView.layer.anchorPoint = CGPointMake(0.5, 1);
    }
    return _babyRightEyeView;
}

- (UIImageView *)badyPlaneView {
    if (!_badyPlaneView) {
        _badyPlaneView = [[UIImageView alloc] init];
        _badyPlaneView.image = [UIImage imageNamed:@"tyloding_baby_plane"];
//        _badyPlaneView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _badyPlaneView;
}

@end
