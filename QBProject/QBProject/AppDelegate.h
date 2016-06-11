//
//  AppDelegate.h
//  QBProject
//
//  Created by QuincyYan on 16/6/11.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
/// 栈
@property (nonatomic,strong) TYNavigationStack *navigationControllerStack;

@end

