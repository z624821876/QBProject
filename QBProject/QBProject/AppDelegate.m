//
//  AppDelegate.m
//  QBProject
//
//  Created by QuincyYan on 16/6/11.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "AppDelegate.h"
#import "TYViewModelService.h"
#import "TYViewModelServiceImpl.h"
#import "QBTabbarViewModel.h"

@interface AppDelegate ()
@property (nonatomic,strong) TYViewModelServiceImpl *serviceImpl;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _serviceImpl = [[TYViewModelServiceImpl alloc] init];
    _navigationControllerStack = [[TYNavigationStack alloc] initWithService:_serviceImpl];
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    [_serviceImpl resetRootViewModel:[[QBTabbarViewModel alloc] initWithService:self.serviceImpl params:nil]];
    [_window makeKeyAndVisible];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

@end
