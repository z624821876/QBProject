//
//  QBUserViewModel.m
//  QBProject
//
//  Created by QuincyYan on 16/6/13.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "QBUserViewModel.h"
#import "QBSettingViewModel.h"
#import "QBLoginViewModel.h"

@implementation QBUserViewModel

- (void)initialize {
    [super initialize];
    
    self.title = @"我的区域";
    self.isHiddenBackBarButton = YES;
    self.userModel = [QBUserModel currUser];
    
    self.userHeadCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        if ([QBUserModel isUserLogin].boolValue) {
            QBSettingViewModel *viewModel = [[QBSettingViewModel alloc] initWithService:self.service params:nil];
            [self.service pushViewModel:viewModel animated:YES];
        }else {
            QBLoginViewModel *viewModel = [[QBLoginViewModel alloc] initWithService:self.service params:nil];
            [self.service pushViewModel:viewModel animated:YES];
        }
        return [RACSignal empty];
    }];
}



@end
