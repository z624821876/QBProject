//
//  TYCollectionViewController.m
//  MPProject
//
//  Created by QuincyYan on 16/6/2.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import "TYCollectionViewController.h"
#import "TYCollectionViewModel.h"

@interface TYCollectionViewController () <UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong) TYCollectionViewModel *viewModel;

@end

@implementation TYCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView = [[TPKeyboardAvoidingCollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - 64) collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
}

- (void)bindViewModel {
    [super bindViewModel];
    
    @weakify(self);
    [RACObserve(self.viewModel, viewLayout)
     subscribeNext:^(UICollectionViewLayout *viewLayout) {
         @strongify(self);
         if (viewLayout) {
             [self.collectionView setCollectionViewLayout:viewLayout];
         }
    }];
    
    [RACObserve(self.viewModel, viewFlowLayout)
     subscribeNext:^(UICollectionViewFlowLayout *viewFlowLayout) {
         @strongify(self);
         if (viewFlowLayout) {
             [self.collectionView setCollectionViewLayout:viewFlowLayout];
         }
     }];
    
    [RACObserve(self.viewModel, flowLayoutPadding)
     subscribeNext:^(NSNumber *padding) {
         @strongify(self);
         [self.collectionView setContentInset:UIEdgeInsetsMake(padding.floatValue, padding.floatValue, padding.floatValue, padding.floatValue)];
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.viewModel.dataSource count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    [self.viewModel.didSelectedCommand execute:indexPath];
}

@end
