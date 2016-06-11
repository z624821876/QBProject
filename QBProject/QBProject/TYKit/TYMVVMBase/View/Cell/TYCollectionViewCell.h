//
//  TYCollectionViewCell.h
//  UEProject
//
//  Created by QuincyYan on 16/5/19.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TYCollectionViewCell : UICollectionViewCell

/// 绑定模型
- (void)bindWithDataSource:(NSObject *)dataSource;

/// 绑定‘ViewModel‘
- (void)bindWithViewModel:(TYViewModel *)viewModel andIndexpath:(NSIndexPath *)indexpath;

/// 绑定‘ViewModel‘以及赋值
- (void)bindWithViewModel:(TYViewModel *)viewModel dataSource:(NSObject *)dataSource indexpath:(NSIndexPath *)indexpath;

@end
