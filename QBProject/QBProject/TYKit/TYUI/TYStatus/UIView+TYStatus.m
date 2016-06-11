//
//  UIView+TYStatus.m
//  ULove
//
//  Created by TimothyYan on 16/3/21.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import "UIView+TYStatus.h"
#import <objc/runtime.h>

@implementation UIView (TYStatus)
static char TYStatusViewKey, TYStatusHandlerKey, TYLoadingViewKey;


- (void)showStatusWithStyle:(TYStatusStyle)style responseHandler:(TYStatusResponseHandler)handler {
    switch (style) {
        case TYStatusStyleFail:{
            [self showStatusWithImage:@"mm_network_fail" description:@"加载失败请点击重试" responseHandler:handler];
        }
            break;
        case TYStatusStyleEmptyData:{
            [self showStatusWithImage:@"mm_network_empty" description:@"暂无相关数据" responseHandler:handler];
        }
            break;
        case TYStatusStyleNetworkError:{
            [self showStatusWithImage:@"mm_network_error" description:@"网络异常请点击重试" responseHandler:handler];
        }
            break;
        default:
            break;
    }
}

- (void)showStatusWithImage:(NSString *)image description:(NSString *)desc responseHandler:(TYStatusResponseHandler)handler {
    if (!self.statusView) {
        self.statusView = [[TYStatusView alloc] init];
    }
    self.statusView.textLabel.text = desc;
    self.statusView.iconImageView.image = [UIImage imageNamed:image];
    self.handler = handler;
    [self addSubview:self.statusView];
    [self.statusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    @weakify(self);
    [[self.statusView rac_signalForControlEvents:1<<6]
     subscribeNext:^(id x) {
         @strongify(self);
         if (self.handler) {
             self.handler();
             
             [self.statusView removeFromSuperview];
             self.statusView = nil;
         }
     }];
}

- (void)startLoading {
    if (!self.loadingView) {
        self.loadingView = [[TYLoadingView alloc] init];
    }
    [self addSubview:self.loadingView];
    [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.loadingView startLoading];
}

- (void)stopLoading {
    if (self.loadingView) {
        [self.loadingView stopLoading];
        [self.loadingView removeFromSuperview];
    }
}

- (TYLoadingView *)loadingView {
    return objc_getAssociatedObject(self, &TYLoadingViewKey);
}

- (void)setLoadingView:(TYLoadingView *)loadingView {
    objc_setAssociatedObject(self, &TYLoadingViewKey, loadingView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (TYStatusView *)statusView {
    return objc_getAssociatedObject(self, &TYStatusViewKey);
}

- (void)setStatusView:(TYStatusView *)statusView {
    objc_setAssociatedObject(self, &TYStatusViewKey, statusView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (TYStatusResponseHandler)handler {
    return objc_getAssociatedObject(self, &TYStatusHandlerKey);
}

- (void)setHandler:(TYStatusResponseHandler)handler {
    objc_setAssociatedObject(self, &TYStatusHandlerKey, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end




@implementation TYStatusView

- (instancetype)init {
    if (self!=[super init]) {
        return nil;
    }
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_centerY).offset(20);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    [self addSubview:self.textLabel];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.iconImageView.mas_bottom).offset(20);
    }];
    
    return self;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.backgroundColor = [UIColor clearColor];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconImageView;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        [_textLabel setFont:[UIFont systemFontOfSize:15]];
        _textLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
        _textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _textLabel;
}

@end




@interface TYLoadingView()
@property (nonatomic,strong) UIImageView *spotView ,*imageView;
@property (nonatomic,strong) CADisplayLink *animateLink;
@property (nonatomic,assign) CGFloat progress;

@end


@implementation TYLoadingView

- (instancetype)init {
    if (self!=[super init]) {
        return nil;
    }
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.spotView];
    [self addSubview:self.imageView];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(60, 9));
    }];
    
    [self.spotView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(130, 130));
    }];
    
    return self;
}

- (void)startLoading {
    self.progress = 0;
    self.animateLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(animateLinkHandler)];
    [self.animateLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)animateLinkHandler {
    self.progress ++;
    self.spotView.transform = CGAffineTransformMakeRotation(M_PI * self.progress / 60);
}

- (void)stopLoading {
    if (self.animateLink) {
        [self.animateLink invalidate]; self.animateLink = nil;
    }
}

-(UIImageView *)spotView {
    if (!_spotView) {
        _spotView = [[UIImageView alloc] init];
        _spotView.image = [UIImage imageNamed:@"mm_loading_spot"];
    }
    return _spotView;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.image = [UIImage imageNamed:@"mm_loading_text"];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

@end
