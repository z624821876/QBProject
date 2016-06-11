//
//  UETableViewController.h
//  ULove
//
//  Created by TimothyYan on 16/3/29.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import "TYViewController.h"

@class TPKeyboardAvoidingTableView;
@interface TYTableViewController : TYViewController<UITableViewDataSource,UITableViewDelegate>

/// 视图
/// 视图默认‘separatorStyle’为‘UITableViewCellSeparatorStyleNone’
/// 视图尺寸默认充满整个控件
@property (nonatomic,strong) TPKeyboardAvoidingTableView *tableView;

/// 设置底部视图
/// 底部视图外部有一层‘View’
/// 底部视图为于该层‘View’居中,并且距离该‘View’顶部为自身‘Frame’的Y值
- (void)setSheetView:(UIView *)sheetView;

/// 设置头部视图
- (void)setHeaderView:(UIView *)headerView;

@end
