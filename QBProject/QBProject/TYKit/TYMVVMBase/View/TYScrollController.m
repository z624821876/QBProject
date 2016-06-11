//
//  TYScrollController.m
//  UEProject
//
//  Created by yanyibin on 16/4/24.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import "TYScrollController.h"

@interface TYScrollController()

@end

@implementation TYScrollController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (TPKeyboardAvoidingScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[TPKeyboardAvoidingScrollView alloc] init];
    }
    return _scrollView;
}

@end
