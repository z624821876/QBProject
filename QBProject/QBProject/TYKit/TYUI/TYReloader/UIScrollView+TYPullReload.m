//
//  UIScrollView+TYPullReload.m
//  TYKit
//
//  Created by QuincyYan on 16/4/21.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import "UIScrollView+TYPullReload.h"
#import <objc/runtime.h>

static CGFloat const TYPullReloadViewHeight = 60;
static char TYPullReloadKey;

@implementation UIScrollView (TYPullReload)

- (void)addPullReloadWithHandler:(void (^)())handler {
    if (!self.pullReloadView) {
        TYPullReloadView *view = [[TYPullReloadView alloc] initWithFrame:CGRectMake(0, - TYPullReloadViewHeight, self.bounds.size.width, TYPullReloadViewHeight)];
        view.scrollView = self;
        view.originalEdgeInsets = self.contentInset;
        view.pullReloadHandler = handler;
        [self addSubview:view];
        
        self.pullReloadView = view;
        
        [self addObserver:self.pullReloadView forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (void)setPullReloadView:(TYPullReloadView *)pullReloadView {
    [self willChangeValueForKey:@"TYPullReloadKey"];
    objc_setAssociatedObject(self, &TYPullReloadKey,pullReloadView,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"TYPullReloadKey"];
}

- (TYPullReloadView *)pullReloadView {
    return objc_getAssociatedObject(self, &TYPullReloadKey);
}

@end
