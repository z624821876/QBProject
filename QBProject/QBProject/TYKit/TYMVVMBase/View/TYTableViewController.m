//
//  UETableViewController.m
//  ULove
//
//  Created by TimothyYan on 16/3/29.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import "TYTableViewController.h"

@interface TYTableViewController()
/// ‘ViewModel’
/// 当‘dataSource’变的时候,会自动‘reload’
/// dataSource基本构成为一个section -> @[],
@property (nonatomic,strong) TYTableViewModel *viewModel;

@end

@implementation TYTableViewController

- (instancetype)initWithViewModel:(TYViewModel *)viewModel{
    self = [super initWithViewModel:viewModel];
    if (self) {
        if (viewModel.shouldLoadDataInitially) {
            @weakify(self);
            [[self rac_signalForSelector:@selector(viewDidLoad)]
             subscribeNext:^(id x) {
                @strongify(self);
                [self.tableView.pullLoadingView startPullLoading];
            }];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - 64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

- (void)bindSubView {
    
}

- (void)bindViewModel{
    [super bindViewModel];
    
    @weakify(self);
    [RACObserve(self.viewModel, dataSource).distinctUntilChanged.deliverOnMainThread
     subscribeNext:^(id x) {
         @strongify(self);
         [self.tableView reloadData];
     }];
}

- (void)setHeaderView:(UIView *)headerView {
    self.tableView.tableHeaderView = headerView;
}

- (void)setSheetView:(UIView *)sheetView {
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, CGRectGetHeight(sheetView.frame) + CGRectGetMinY(sheetView.frame))];
    [footView addSubview:sheetView];
    
    [sheetView setFrame:CGRectMake((kScreenW - CGRectGetWidth(sheetView.frame)) / 2,
                                   CGRectGetMinY(sheetView.frame),
                                   CGRectGetWidth(sheetView.frame),
                                   CGRectGetHeight(sheetView.frame))];
    self.tableView.tableFooterView = footView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.viewModel.dataSource count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [TYTableViewCell cellHeightWithModel:self.viewModel.dataSource[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.viewModel.didSelectedCommand execute:indexPath];
}

- (void)dealloc {
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
}

@end
