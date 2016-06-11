//
//  NSObject+Property.m
//  ULove
//
//  Created by TimothyYan on 16/3/21.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import "NSObject+Property.h"

@implementation NSObject (Property)

+ (NSArray *)propertys{
    unsigned int count;
    Ivar *ivarList = class_copyIvarList(self, &count);
    NSMutableArray *keys = [NSMutableArray new];
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivarList[i];
        NSString *name = [NSString stringWithUTF8String:ivar_getName(ivar)];
        NSString *key = [name substringFromIndex:1];
        [keys addObject:key];
    }
    return keys;
}

- (id)valueOfKey:(NSString *)key{
    SEL value = NSSelectorFromString(key);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    return [self performSelector:value];
#pragma clang diagnostic pop
}

- (id)classCopy{
    NSArray *keys = [[self class] propertys];
    id class = [[[self class] alloc] init];
    for (NSString *key in keys) {
        [class setValue:[self valueOfKey:key] forKey:key];
    }
    return class;
}

- (NSDictionary *)propertyToDictionary {
    NSArray *propertys = [[self class] propertys];
    if (propertys && propertys.count > 0) {
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        for (int i = 0; i < propertys.count; i++) {
            id value = [self valueForKey:propertys[i]];
            if (!value) {
                [params setObject:value forKey:propertys[i]];
            }
        }
        return params;
    }
    return [[NSDictionary alloc] init];
}

@end
