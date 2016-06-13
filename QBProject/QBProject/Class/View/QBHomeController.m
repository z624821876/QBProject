//
//  QBHomeController.m
//  QBProject
//
//  Created by QuincyYan on 16/6/13.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "QBHomeController.h"
#import "QBHomeViewModel.h"
#import "QBDisclosureCell.h"

@interface QBHomeController ()

@property (nonatomic,strong) QBHomeViewModel *viewModel;
@end

@implementation QBHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[QBDisclosureCell class] forCellReuseIdentifier:@"QBDisclosureCell"];
}

- (void)bindViewModel {
    [super bindViewModel];
    
    @weakify(self);
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QBDisclosureCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QBDisclosureCell"];
    [cell bindWithDataSource:self.viewModel.dataSource[indexPath.row] indexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
