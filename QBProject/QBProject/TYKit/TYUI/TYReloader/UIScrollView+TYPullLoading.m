//
//  UIScrollView+TYPullLoading.m
//  TYKit
//
//  Created by QuincyYan on 16/4/21.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import "UIScrollView+TYPullLoading.h"
#import <objc/runtime.h>

static CGFloat const TYPullLoadingViewHeight = 60;
static char TYPullLoadingKey;

@implementation UIScrollView (TYPullLoading)

- (void)addPullLoadingWithHandler:(void (^)())handler {
    if (!self.pullLoadingView) {
        TYPullLoadingView *view = [[TYPullLoadingView alloc] initWithFrame:CGRectMake(0, self.contentSize.height, self.bounds.size.width, TYPullLoadingViewHeight)];
        view.scrollView = self;
        view.originalEdgeInsets = self.contentInset;
        view.pullLoadingHandler = handler;
        [self addSubview:view];
        
        self.pullLoadingView = view;
        
        [self addObserver:self.pullLoadingView forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self.pullLoadingView forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (void)setPullLoadingView:(TYPullLoadingView *)pullLoadingView {
    [self willChangeValueForKey:@"TYPullLoadingKey"];
    objc_setAssociatedObject(self, &TYPullLoadingKey,pullLoadingView,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"TYPullLoadingKey"];
}

- (TYPullLoadingView *)pullLoadingView {
    return objc_getAssociatedObject(self, &TYPullLoadingKey);
}

@end
