//
//  QBDisclosureCell.m
//  QBProject
//
//  Created by QuincyYan on 16/6/13.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "QBDisclosureCell.h"

@interface QBDisclosureCell()
@property (nonatomic,strong) UILabel *propertyLabel;
@property (nonatomic,strong) UIImageView *propertyImageView, *disclosoureImageView;
@property (nonatomic,strong) UIView *bottomSpliter;
@end

@implementation QBDisclosureCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self != [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        return nil;
    }
    
    [self.contentView addSubview:self.propertyImageView];
    [self.propertyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    [self.contentView addSubview:self.propertyLabel];
    [self.propertyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.propertyImageView.mas_right).offset(10);
        make.centerY.equalTo(self.propertyImageView);
    }];
    
    [self.contentView addSubview:self.disclosoureImageView];
    [self.disclosoureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.bottomSpliter];
    [self.bottomSpliter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(0.5f);
    }];
    
    return self;
}

- (void)bindWithDataSource:(NSDictionary *)dataSource indexPath:(NSIndexPath *)indexPath {
    self.propertyImageView.image = [UIImage imageNamed:dataSource[@"image"]];
    self.propertyLabel.text = dataSource[@"property"];
}

- (UILabel *)propertyLabel {
    if (!_propertyLabel) {
        _propertyLabel = [[UILabel alloc] init];
        _propertyLabel.font = [UIFont systemFontOfSize:15];
        _propertyLabel.textColor = QBThemeTextColor;
    }
    return _propertyLabel;
}

- (UIImageView *)propertyImageView {
    if (!_propertyImageView) {
        _propertyImageView = [[UIImageView alloc] init];
    }
    return _propertyImageView;
}

- (UIImageView *)disclosoureImageView {
    if (!_disclosoureImageView) {
        _disclosoureImageView = [[UIImageView alloc] init];
    }
    return _disclosoureImageView;
}

-(UIView *)bottomSpliter {
    if (!_bottomSpliter) {
        _bottomSpliter = [UIView viewWithColor:QBSpliterColor];
    }
    return _bottomSpliter;
}

@end
