//
//  UEViewModel.m
//  ULove
//
//  Created by TimothyYan on 16/3/26.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import "TYViewModel.h"

@interface TYViewModel()

@end

@implementation TYViewModel

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    TYViewModel *viewModel = [super allocWithZone:zone];
    @weakify(viewModel);
    [[viewModel rac_signalForSelector:@selector(initWithService:params:)]
     subscribeNext:^(id x) {
        @strongify(viewModel);
        [viewModel initialize];
    }];
    return viewModel;
}

- (instancetype)initWithService:(id<TYViewModelService>)service params:(NSDictionary *)params{
    if (self!=[super init]) {
        return nil;
    }
    self.service = service;
    self.params = params;
    return self;
}

- (void)initialize {
    @weakify(self);
    self.backBarCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self.service popViewModelAnimated:YES];
        return [RACSignal empty];
    }];
};

- (void)dealloc {
    NSLog(@"dealloc:%@",NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end