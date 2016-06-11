//
//  TYTableViewCell.m
//  MagicMask
//
//  Created by yanyibin on 16/4/7.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import "TYTableViewCell.h"

@implementation TYTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    return self;
}

- (void)bindWithDataSource:(NSObject *)dataSource indexPath:(NSIndexPath *)indexPath {}

- (void)bindWithViewModel:(TYViewModel *)viewModel indexPath:(NSIndexPath *)indexPath {}

- (void)bindWithViewModel:(TYViewModel *)viewModel dataSource:(NSObject *)dataSource indexPath:(NSIndexPath *)indexPath{};

+ (CGFloat)cellHeightWithModel:(NSObject *)model {return 44;}

@end
