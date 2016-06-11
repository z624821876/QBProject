//
//  TYNavigationStack.m
//  ULove
//
//  Created by TimothyYan on 16/3/27.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import "TYNavigationStack.h"
#import "TYRouter.h"
#import "AppDelegate.h"

@interface TYNavigationStack()
@property (nonatomic,strong) id<TYViewModelService> service;
@property (nonatomic,strong) NSMutableArray *navigationControllers;

@end

@implementation TYNavigationStack

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    TYNavigationStack *navigationControllerStack = [super allocWithZone:zone];
    
    @weakify(navigationControllerStack)
    [[navigationControllerStack
      rac_signalForSelector:@selector(initWithService:)]
    	subscribeNext:^(id x) {
            @strongify(navigationControllerStack)
            [navigationControllerStack registerNavigationHooks];
        }];
    
    return navigationControllerStack;
}

-(instancetype)initWithService:(id<TYViewModelService>)service{
    if (self!=[super init]) {
        return nil;
    }
    self.service = service;
    self.navigationControllers = [[NSMutableArray alloc] init];
    return self;
}

- (void)pushNavigationController:(UINavigationController *)navigationController{
    if ([self.navigationControllers containsObject:navigationController]) {
        return;
    }
    [self.navigationControllers addObject:navigationController];
}

- (UINavigationController *)popNavigationController{
    UINavigationController *navigationController = [self.navigationControllers lastObject];
    [self.navigationControllers removeLastObject];
    return navigationController;
}

- (UINavigationController *)topNavigationController{
    return self.navigationControllers.lastObject;
}

- (void)registerNavigationHooks{
    @weakify(self);
    [[(NSObject *)self.service
      rac_signalForSelector:@selector(pushViewModel:animated:)]
     subscribeNext:^(RACTuple *tuple) {
         @strongify(self);
         TYViewModel *viewModel = (TYViewModel *)tuple.first;
         UIViewController *viewController = [[TYRouter sharedRouter] viewControllerWithViewModel:viewModel];
         viewController = [viewController classWithParams:viewModel.params];
         viewController.hidesBottomBarWhenPushed = YES;
         [self.navigationControllers.lastObject pushViewController:viewController animated:tuple.second];
     }];
    
    [[(NSObject *)self.service
      rac_signalForSelector:@selector(popViewModelAnimated:)]
     subscribeNext:^(RACTuple *tuple) {
         @strongify(self);
         [self.navigationControllers.lastObject popViewControllerAnimated:[tuple.first boolValue]];
     }];
    
    [[(NSObject *)self.service
      rac_signalForSelector:@selector(popToRootViewModelAnimated:)]
     subscribeNext:^(RACTuple *tuple) {
         @strongify(self)
         [self.navigationControllers.lastObject popToRootViewControllerAnimated:[tuple.first boolValue]];
     }];
    
    [[(NSObject *)self.service
      rac_signalForSelector:@selector(resetRootViewModel:)]
     subscribeNext:^(RACTuple *tuple) {
         @strongify(self);
         [self.navigationControllers removeAllObjects];
         
         UIViewController *viewController = [[TYRouter sharedRouter] viewControllerWithViewModel:tuple.first];
         if (![viewController isKindOfClass:[UINavigationController class]] && ![viewController isKindOfClass:[TYTabbarController class]]) {
             viewController = [[TYNaviController alloc] initWithRootViewController:viewController];
             [self pushNavigationController:(UINavigationController *)viewController];
         }
         
         ((AppDelegate *)[UIApplication sharedApplication].delegate).window.rootViewController = viewController;
     }];
    
    [[(NSObject *)self.service
      rac_signalForSelector:@selector(presentViewModel:animated:completion:)]
     subscribeNext:^(RACTuple *tuple) {
         @strongify(self);
         UIViewController *viewController = (UIViewController *)[TYRouter.sharedRouter viewControllerWithViewModel:tuple.first];
         
         UINavigationController *presentingViewController = self.navigationControllers.lastObject;
         if (![viewController isKindOfClass:UINavigationController.class]) {
             viewController = [[TYNaviController alloc] initWithRootViewController:viewController];
         }
         [self pushNavigationController:(UINavigationController *)viewController];
         
         [presentingViewController presentViewController:viewController animated:[tuple.second boolValue] completion:tuple.third];
     }];
    
    [[(NSObject *)self.service
      rac_signalForSelector:@selector(dismissViewModelAnimated:completion:)]
     subscribeNext:^(RACTuple *tuple) {
         @strongify(self)
         [self popNavigationController];
         [self.navigationControllers.lastObject dismissViewControllerAnimated:[tuple.first boolValue] completion:tuple.second];
     }];
}

@end
