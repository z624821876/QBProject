//
//  TYTableViewCell.h
//  MagicMask
//
//  Created by yanyibin on 16/4/7.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TYTableViewCell : UITableViewCell

/// 绑定模型
- (void)bindWithDataSource:(NSObject *)dataSource indexPath:(NSIndexPath *)indexPath;

/// 绑定‘ViewModel‘
- (void)bindWithViewModel:(TYViewModel *)viewModel indexPath:(NSIndexPath *)indexPath;

/// 绑定‘ViewModel‘以及赋值
- (void)bindWithViewModel:(TYViewModel *)viewModel dataSource:(NSObject *)dataSource indexPath:(NSIndexPath *)indexPath;

/// 计算高度
+ (CGFloat)cellHeightWithModel:(NSObject *)model;

@end
