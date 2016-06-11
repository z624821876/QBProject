//
//  TYTabbarController.m
//  UEProject
//
//  Created by QuincyYan on 16/4/23.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import "TYTabbarController.h"
#import "TYTabbar.h"
#import "TYTabbarViewModel.h"

@interface TYTabbarController()<TYTabbarDelegate>
@property (nonatomic,strong) TYTabbar *tyTabbar;

@property (nonatomic,strong) TYTabbarViewModel *viewModel;
@end

@implementation TYTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)bindSubView {
    [super bindSubView];
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.view.frame = self.view.bounds;
    [self addChildViewController:self.tabBarController];
    [self.view addSubview:self.tabBarController.view];
    [self.tabBarController.tabBar setShadowImage:[UIImage new]];
    [self.tabBarController.tabBar setBackgroundImage:[UIImage new]];
}

- (void)bindViewModel {
    [super bindViewModel];
    
    @weakify(self);
    [RACObserve(self.viewModel, viewControllers)
     subscribeNext:^(NSArray *viewControllers) {
         @strongify(self);
         self.tabBarController.viewControllers = viewControllers;
         [self.tabBarController.tabBar addSubview:self.tyTabbar];
     }];
    
    [RACObserve(self.viewModel, entitys).distinctUntilChanged
     subscribeNext:^(NSArray *entitys) {
         @strongify(self);
         self.tyTabbar.entitys = entitys;
         [self.tyTabbar reloadEntitys];
    }];
    
    [RACObserve(self.viewModel, selectedIndex)
     subscribeNext:^(NSNumber *selectedIndex) {
         @strongify(self);
         self.tabBarController.selectedIndex = selectedIndex.integerValue;
         self.tyTabbar.selectedIndex = selectedIndex.integerValue;
    }];
}

- (BOOL)TYTabbar:(TYTabbar *)TYTabbar didSelectedEntityInIndex:(NSInteger)index {
    self.tabBarController.selectedIndex = index;
    [QBSharedAppDelegate.navigationControllerStack popNavigationController];
    [QBSharedAppDelegate.navigationControllerStack pushNavigationController:self.viewModel.viewControllers[index]];
    return YES;
}

- (TYTabbar *)tyTabbar {
    if (!_tyTabbar) {
        _tyTabbar =[[TYTabbar alloc] init];
        [_tyTabbar setFrame:self.tabBarController.tabBar.bounds];
        _tyTabbar.tyDelegate = self;
    }
    return _tyTabbar;
}

@end
