//
//  QBUserViewModel.m
//  QBProject
//
//  Created by QuincyYan on 16/6/13.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "QBUserViewModel.h"

@implementation QBUserViewModel

- (void)initialize {
    [super initialize];
    
    self.title = @"我的";
    self.isHiddenBackBarButton = YES;
}

@end
