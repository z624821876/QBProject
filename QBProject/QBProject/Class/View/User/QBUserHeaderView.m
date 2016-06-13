//
//  QBUserHeaderView.m
//  QBProject
//
//  Created by QuincyYan on 16/6/13.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "QBUserHeaderView.h"
#import "QBUserViewModel.h"

@interface QBUserHeaderView()
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIButton *headButton;
/// 黑色遮罩层
@property (nonatomic,strong) UIView *coverView;
@property (nonatomic,strong) UILabel *nameLabel;

@property (nonatomic,strong) QBUserViewModel *viewModel;
@end

@implementation QBUserHeaderView

- (instancetype)initWithViewModel:(TYViewModel *)viewModel {
    if (self != [super initWithViewModel:viewModel]) {
        return nil;
    }
    
    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self addSubview:self.coverView];
    [self.coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self addSubview:self.headButton];
    [self.headButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(10);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.headButton.mas_bottom).offset(15);
    }];
    
    return self;
}

- (void)bindViewModel {
    [super bindViewModel];
    
    @weakify(self);
    [[self.headButton rac_signalForControlEvents:1<<6]
     subscribeNext:^(id x) {
         @strongify(self);
         [self.viewModel.userHeadCommand execute:nil];
     }];
    
    [RACObserve(self.viewModel.userModel, name)
     subscribeNext:^(NSString *name) {
         if (name && name.length > 0) {
             self.nameLabel.text = name;
         }else {
             self.nameLabel.text = @"请设置昵称";
         }
    }];
}

- (UIView *)coverView {
    if (!_coverView) {
        _coverView = [UIView viewWithColor:[[UIColor blackColor] colorWithAlphaComponent:0.4f]];
    }
    return _coverView;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.image = [UIImage imageNamed:@"user_background_city.jpg"];
    }
    return _imageView;
}

- (UIButton *)headButton {
    if (!_headButton) {
        _headButton = [[UIButton alloc] init];
        [_headButton cornerRadius:40.0 width:0.0f color:nil];
        [_headButton setImage:[[UIImage imageNamed:@"qb_user_default"] scale:2.3f] forState:0];
        _headButton.backgroundColor = [UIColor whiteColor];
    }
    return _headButton;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont boldSystemFontOfSize:15];
        _nameLabel.text = @"请先登录";
    }
    return _nameLabel;
}

@end
