//
//  QBLoginController.m
//  QBProject
//
//  Created by QuincyYan on 16/6/13.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "QBLoginController.h"
#import "QBUsernameView.h"
#import "QBPasswordView.h"
#import "QBLoginViewModel.h"

@interface QBLoginController ()
@property (nonatomic,strong) QBUsernameView *usernameView;
@property (nonatomic,strong) QBPasswordView *passwordView;

@property (nonatomic,strong) QBLoginViewModel *viewModel;
@end

@implementation QBLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.scrollView addSubview:self.usernameView];
    [self.usernameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView).offset(20);
        make.width.mas_equalTo(kScreenW - 40);
        make.height.mas_equalTo(40);
        make.top.equalTo(self.scrollView).offset(80);
    }];
    
    [self.scrollView addSubview:self.passwordView];
    [self.passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(self.usernameView);
        make.top.equalTo(self.usernameView.mas_bottom).offset(10);
    }];
}

- (QBUsernameView *)usernameView {
    if (!_usernameView) {
        _usernameView = [[QBUsernameView alloc] initWithViewModel:self.viewModel];
    }
    return _usernameView;
}

- (QBPasswordView *)passwordView {
    if (!_passwordView) {
        _passwordView = [[QBPasswordView alloc] initWithViewModel:self.viewModel];
    }
    return _passwordView;
}

@end
