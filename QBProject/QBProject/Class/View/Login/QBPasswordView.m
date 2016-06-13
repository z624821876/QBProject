//
//  QBPasswordView.m
//  QBProject
//
//  Created by QuincyYan on 16/6/13.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "QBPasswordView.h"

@interface QBPasswordView()
@property (nonatomic,strong) UIImageView *iconView;
@property (nonatomic,strong) UITextField *inputTextField;

@end

@implementation QBPasswordView

- (instancetype)initWithViewModel:(TYViewModel *)viewModel {
    if (self != [super initWithViewModel:viewModel]) {
        return nil;
    }
    
    [self addSubview:self.iconView];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    [self addSubview:self.inputTextField];
    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.mas_right).offset(10);
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-10);
    }];
    
    [self viewInsertBottomSpliterWithColor:QBAssistTextColor appendPadding:NO];
    
    return self;
}

- (void)bindViewModel {
    [super bindViewModel];
    
    @weakify(self);
}

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.image = [UIImage imageNamed:@"user_login_password"];
    }
    return _iconView;
}

- (UITextField *)inputTextField {
    if (!_inputTextField) {
        _inputTextField = [[UITextField alloc] init];
        _inputTextField.font = [UIFont systemFontOfSize:14];
        _inputTextField.textColor = QBNormalTextColor;
        _inputTextField.placeholder = @"6位以上密码";
    }
    return _inputTextField;
}

@end
