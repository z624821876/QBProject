//
//  TYPullLoadingView.m
//  TYKit
//
//  Created by QuincyYan on 16/5/31.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import "TYPullLoadingView.h"

static CGFloat const TYPullLoadingViewHeight = 60;

@interface TYPullLoadingView()
/// 等待框
@property (nonatomic,strong) UIActivityIndicatorView *activityView;
/// 文字控件
@property (nonatomic,strong) UILabel *textLabel;

@end

@implementation TYPullLoadingView

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
        CGFloat offsetY = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue].y;
        CGFloat willChangeY = [self pullLoadingWillChangeY];
        CGFloat willChangeLoading = willChangeY + TYPullLoadingViewHeight;
        
        if (self.pullLoadingState != TYPullLoadingStateLoading) {
            if (offsetY >= willChangeY && offsetY <= willChangeLoading) {
                self.pullLoadingState = TYPullLoadingStateOriginal;
            }
            if (offsetY >= willChangeLoading) {
                if (!self.scrollView.isDragging) {
                    self.pullLoadingState = TYPullLoadingStateLoading;
                }else {
                    self.pullLoadingState = TYPullLoadingStatePulling;
                }
            }
        }
    }else if([keyPath isEqualToString:@"contentSize"]) {
        [self resetViewsFrame];
    }
}

/// 重新设置自身的‘Frame‘
- (void)resetViewsFrame {
    [self setFrame:CGRectMake(self.originalEdgeInsets.left,
                              [self pullLoadingY],
                              CGRectGetMaxX(self.scrollView.frame) - self.originalEdgeInsets.left - self.originalEdgeInsets.right,
                              TYPullLoadingViewHeight)];
}

/// 获取自身控件的‘Y’
- (CGFloat)pullLoadingY {
    CGFloat contentEdges = self.originalEdgeInsets.top + self.originalEdgeInsets.bottom;
    CGFloat contentSize = self.scrollView.contentSize.height;
    CGFloat tableViewSize = CGRectGetHeight(self.scrollView.frame);
    
    if (contentEdges + contentSize < tableViewSize) {
        return tableViewSize;
    }
    return contentEdges + contentSize;
}

/// 获取刷新控件刷新的状态由’TYPullLoadingStateOriginal‘改变成’TYPullLoadingStatePulling‘的临界点
- (CGFloat)pullLoadingWillChangeY {
    CGFloat contentEdges = self.originalEdgeInsets.top + self.originalEdgeInsets.bottom;
    CGFloat contentSize = self.scrollView.contentSize.height;
    CGFloat tableViewSize = CGRectGetHeight(self.scrollView.frame);
    
    CGFloat willChangeY = contentEdges + contentSize - tableViewSize;
    if (willChangeY < 0) {
        return 0;
    }
    return willChangeY;
}

- (void)setPullLoadingState:(TYPullLoadingState)pullLoadingState {
    _pullLoadingState = pullLoadingState;
    
    switch (pullLoadingState) {
        case TYPullLoadingStateOriginal:{
            self.textLabel.text = @"上拉加载更多";
            [self resetContentEdgeInsets:YES];
            [self.activityView stopAnimating];
        }
            break;
        case TYPullLoadingStatePulling:{
            self.textLabel.text = @"松开加载更多";
        }
            break;
        case TYPullLoadingStateLoading:{
            self.textLabel.text = @"正在加载";
            [self resetContentEdgeInsets:NO];
            [self.activityView startAnimating];
            if (self.pullLoadingHandler) {
                self.pullLoadingHandler();
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
        [self.scrollView setContentInset:UIEdgeInsetsMake(self.originalEdgeInsets.top,
                                                          self.originalEdgeInsets.left,
                                                          self.originalEdgeInsets.bottom + TYPullLoadingViewHeight,
                                                          self.originalEdgeInsets.right)];
    }
}

- (void)stopPullLoading {
    self.pullLoadingState = TYPullLoadingStateOriginal;
}

- (void)startPullLoading {
    self.pullLoadingState = TYPullLoadingStateLoading;
}

- (UIActivityIndicatorView *)activityView {
    if (!_activityView) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return _activityView;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.font = [UIFont fontWithName:@"Lao Sangam MN" size:14];
        _textLabel.textColor = [UIColor colorWithRed:87.0/255.0 green:87.0/255.0 blue:87.0/255.0 alpha:1.0f];
    }
    return _textLabel;
}

@end
