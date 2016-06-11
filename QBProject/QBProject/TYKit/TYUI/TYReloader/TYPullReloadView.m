//
//  TYPullReloadView.m
//  TYKit
//
//  Created by QuincyYan on 16/5/31.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import "TYPullReloadView.h"

static CGFloat const TYPullReloadViewHeight = 60;

@interface TYPullReloadView()
/// 刷新的提示文字
@property (nonatomic,strong) UILabel *textLabel;
/// 等待框
@property (nonatomic,strong) UIActivityIndicatorView *activityView;

@end

@implementation TYPullReloadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self != [super initWithFrame:frame]) {
        return nil;
    }
    
    [self addSubview:self.activityView];
    [self addSubview:self.textLabel];
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    [self.activityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textLabel.mas_right).offset(5);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"contentOffset"]){
        if (self.pullReloadState != TYPullReloadStateReloading) {
            CGFloat offsetY = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue].y;
            CGFloat willChangeY = [self pullReloadWillChangeY];
            
            if (offsetY <= 0 && offsetY >= willChangeY) {
                self.pullReloadState = TYPullReloadStateOriginal;
            }else if (offsetY < willChangeY) {
                if (self.scrollView.isDragging) {
                    self.pullReloadState = TYPullReloadStateWillRelease;
                }else {
                    self.pullReloadState = TYPullReloadStateReloading;
                }
            }
        }
    }
}

- (CGFloat)pullReloadWillChangeY {
    return - TYPullReloadViewHeight;
}

- (void)setPullReloadState:(TYPullReloadState)pullReloadState {
    _pullReloadState = pullReloadState;
    
    switch (pullReloadState) {
        case TYPullReloadStateOriginal:{
            self.textLabel.text = @"下拉刷新";
            [self.activityView stopAnimating];
            [self resetContentEdgeInsets:YES];
        }
            break;
        case TYPullReloadStateWillRelease:{
            self.textLabel.text = @"松开刷新";
        }
            break;
        case TYPullReloadStateReloading:{
            self.textLabel.text = @"正在刷新";
            [self.activityView startAnimating];
            [self resetContentEdgeInsets:NO];
            if (self.pullReloadHandler) {
                self.pullReloadHandler();
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)resetContentEdgeInsets:(BOOL)isFinishLoading {
    if (isFinishLoading) {
        [self.scrollView setContentInset:self.originalEdgeInsets];
    }else {
        [self.scrollView setContentInset:UIEdgeInsetsMake(self.originalEdgeInsets.top + TYPullReloadViewHeight,
                                                          self.originalEdgeInsets.left,
                                                          self.originalEdgeInsets.bottom,
                                                          self.originalEdgeInsets.right)];
    }
}

- (void)stopPullReloading {
    self.pullReloadState = TYPullReloadStateOriginal;
}

- (void)startPullReloading {
    self.pullReloadState = TYPullLoadingStateLoading;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.font = [UIFont fontWithName:@"Lao Sangam MN" size:14];
        _textLabel.textColor = [UIColor colorWithRed:87.0/255.0 green:87.0/255.0 blue:87.0/255.0 alpha:1.0f];
    }
    return _textLabel;
}

- (UIActivityIndicatorView *)activityView {
    if (!_activityView) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return _activityView;
}

@end
