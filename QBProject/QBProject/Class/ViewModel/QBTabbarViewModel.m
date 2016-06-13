//
//  QBTabbarViewModel.m
//  QBProject
//
//  Created by QuincyYan on 16/6/13.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "QBTabbarViewModel.h"
#import "QBHomeViewModel.h"
#import "QBMenuViewModel.h"
#import "QBUserViewModel.h"

@implementation QBTabbarViewModel

- (void)initialize {
    [super initialize];
    
    QBHomeViewModel *homeViewModel = [[QBHomeViewModel alloc] initWithService:self.service params:nil];
    QBMenuViewModel *menuViewModel = [[QBMenuViewModel alloc] initWithService:self.service params:nil];
    QBUserViewModel *userViewModel = [[QBUserViewModel alloc] initWithService:self.service params:nil];
    NSArray *viewModels = @[homeViewModel,menuViewModel,userViewModel];
    
    NSMutableArray *viewControllers = [NSMutableArray array];
    for (int i = 0; i < viewModels.count; i++) {
        TYNaviController *naviController = [[TYRouter sharedRouter] navigationControllerWithViewModel:viewModels[i]];
        [viewControllers addObject:naviController];
    }
    self.viewControllers = viewControllers;
    self.selectedIndex = [NSNumber numberWithInt:0];
    
    
    NSMutableArray *entitys = [[NSMutableArray alloc] init];
    NSArray *titles = @[@"首页",@"吃货",@"我的"];
    NSArray *icons = @[@"tabbar_home_normal",@"tabbar_eat_normal",@"tabbar_user_normal"];
    NSArray *selectedIcons = @[@"tabbar_home_selected",@"tabbar_eat_selected",@"tabbar_user_selected"];
    
    for (int i = 0; i < 3; i++) {
        TYTabbarEntity *entity = [[TYTabbarEntity alloc] init];
        entity.title = titles[i];
        entity.normalStateIcon = icons[i];
        entity.selectedStateIcon = selectedIcons[i];
        entity.normalStateTextColor = QBNormalTextColor;
        entity.selectedStateTextColor = QBThemeColor;
        entity.isOnlyDisplayRedSpot = YES;
        [entitys addObject:entity];
    }
    self.entitys = entitys;
}

@end
