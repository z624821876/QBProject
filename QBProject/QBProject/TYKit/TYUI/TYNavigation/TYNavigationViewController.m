//
//  TYViewController.m
//  TYKit
//
//  Created by TimothyYan on 16/2/18.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import "TYNavigationViewController.h"

@interface TYNavigationViewController ()

@end

@implementation TYNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.navigationController) {
        _tyNavigation = [[TYNavigation alloc] initWithNavigationBar:self.navigationController.navigationBar];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_tyNavigation) {
        [_tyNavigation ty_viewWillAppear];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (_tyNavigation) {
        [_tyNavigation ty_viewWillDisappear];
    }
}

@end
