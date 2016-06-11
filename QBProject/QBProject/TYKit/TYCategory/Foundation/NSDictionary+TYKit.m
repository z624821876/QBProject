//
//  NSDictionary+TYKit.m
//  ULove
//
//  Created by TimothyYan on 16/3/21.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import "NSDictionary+TYKit.h"

@implementation NSDictionary (TYKit)

- (NSString *)serializeKeys{
    NSArray *keys = [self.allKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSLiteralSearch];
    }];
    NSString *soryKey = @"";
    for (NSString *key in keys) {
        soryKey = [soryKey stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,[self objectForKey:key]]];
    }
    return [soryKey substringToIndex:soryKey.length - 1];
}

- (NSDictionary *)keysWithOther:(NSDictionary *)dic{
    NSMutableDictionary *mutableDict = [[NSMutableDictionary alloc] initWithDictionary:self];
    for (NSString *key in dic.allKeys) {
        [mutableDict setObject:[dic objectForKey:key] forKey:key];
    }
    return mutableDict;
}

- (NSString *)XMLString{
    NSString *XML = @"<Body>";
    for (NSString *key in self.allKeys) {
        XML = [XML stringByAppendingString:[NSString stringWithFormat:@"<%@>%@</%@>",key,[self objectForKey:key],key]];
    }
    XML = [XML stringByAppendingString:@"</Body>"];
    return XML;
}

@end
