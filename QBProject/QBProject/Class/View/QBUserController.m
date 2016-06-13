//
//  QBUserController.m
//  QBProject
//
//  Created by QuincyYan on 16/6/13.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "QBUserController.h"
#import "QBUserHeaderView.h"
#import "QBUserViewModel.h"

@interface QBUserController ()
@property (nonatomic,strong) QBUserHeaderView *userHeaderView;

@property (nonatomic,strong) QBUserViewModel *viewModel;
@end

@implementation QBUserController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.edgesForExtendedLayout = UIRectEdgeAll;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"QBUserCell"];
    [self.tableView addParallaxWithView:self.userHeaderView andHeight:CGRectGetHeight(self.userHeaderView.frame)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QBUserCell"];
    cell.textLabel.text = self.viewModel.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (QBUserHeaderView *)userHeaderView {
    if (!_userHeaderView) {
        _userHeaderView = [[QBUserHeaderView alloc] initWithViewModel:self.viewModel];
        _userHeaderView.frame = CGRectMake(0, 0, kScreenW, 220);
    }
    return _userHeaderView;
}

@end
