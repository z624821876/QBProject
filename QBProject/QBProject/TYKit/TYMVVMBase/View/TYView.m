//
//  TYBasicView.m
//  ULove
//
//  Created by TimothyYan on 16/3/29.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import "TYView.h"

@interface TYView()
@property (nonatomic,strong) TYViewModel *viewModel;
@end

@implementation TYView

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    TYView *basicView = [super allocWithZone:zone];
    
    @weakify(basicView);
    [[basicView rac_signalForSelector:@selector(initWithViewModel:)]
     subscribeNext:^(id x) {
         @strongify(basicView);
         [basicView bindViewModel];
     }];
    
    return basicView;
}

- (instancetype)initWithViewModel:(TYViewModel *)viewModel {
    if (self!=[super init]) {
        return nil;
    }
    self.viewModel = viewModel;
    return self;
}

- (void)bindViewModel {
    
}

- (void)dealloc {
    NSLog(@"dealloc:%@",NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
