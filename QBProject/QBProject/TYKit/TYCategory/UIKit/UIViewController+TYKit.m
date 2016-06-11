//
//  UIViewController+TYKit.m
//  ULove
//
//  Created by TimothyYan on 16/3/21.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import "UIViewController+TYKit.h"

@implementation UIViewController (TYKit)

+ (BOOL)searchWithClass:(Class)class property:(NSString *)property{
    unsigned int outCount;
    objc_property_t * properties = class_copyPropertyList(class,&outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property_t = properties[i];
        NSString *key = [[NSString alloc] initWithCString:property_getName(property_t) encoding:NSUTF8StringEncoding];
        if ([key isEqualToString:property]) {
            free(properties);
            return YES;
        }
    }
    free(properties);
    return NO;
}

+ (UIViewController *)classWithIdentity:(NSString *)identity params:(NSDictionary *)params{
    const char *class = [identity cStringUsingEncoding:NSASCIIStringEncoding];
    Class newClass = objc_getClass(class);
    if (!newClass) {
        Class superClass = [NSObject class];
        newClass = objc_allocateClassPair(superClass, class, 0);
        objc_registerClassPair(newClass);
    }
    id instance = [[newClass alloc] init];
    [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL * stop) {
        if ([UIViewController searchWithClass:[self class] property:key]) {
            [instance setValue:params[key] forKey:key];
        }
    }];
    return instance;
}

- (UIViewController *)classWithParams:(NSDictionary *)params{
    [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL * stop) {
        if ([UIViewController searchWithClass:[self class] property:key]) {
            [self setValue:params[key] forKey:key];
        }
    }];
    return self;
}

@end
