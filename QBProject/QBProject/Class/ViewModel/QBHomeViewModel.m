//
//  QBHomeViewModel.m
//  QBProject
//
//  Created by QuincyYan on 16/6/13.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "QBHomeViewModel.h"

@implementation QBHomeViewModel

- (void)initialize {
    [super initialize];
    
    self.title = @"休闲吧";
    self.isHiddenBackBarButton = YES;
    
//    self.dataSource = @[@{@"property":@"灌水区域",
//                          @"image":@"home_star"},
//                        @{@"property":@"面试吐槽",
//                          @"image":@"home_star"},
//                        @{@"property":@"学习资料",
//                          @"image":@"home_star"},];
}

@end
