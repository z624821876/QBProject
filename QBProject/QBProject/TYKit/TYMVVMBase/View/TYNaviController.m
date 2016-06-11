//
//  BasicNaviController.m
//  ULove
//
//  Created by TimothyYan on 16/3/24.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import "TYNaviController.h"

@interface TYNaviController ()

@end

@implementation TYNaviController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.titleTextAttributes = [[NSMutableDictionary alloc] initWithObjects:@[[UIColor whiteColor]]
                                                                                  forKeys:@[NSForegroundColorAttributeName]];
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationBar setShadowImage:[UIImage new]];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}


@end
