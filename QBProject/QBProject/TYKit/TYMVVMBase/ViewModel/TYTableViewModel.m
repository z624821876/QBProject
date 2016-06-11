//
//  UETableViewModel.m
//  ULove
//
//  Created by TimothyYan on 16/3/26.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import "TYTableViewModel.h"

@implementation TYTableViewModel

- (void)initialize {
    [super initialize];
    
    self.page = 0;
    self.dataSource = [NSMutableArray array];
    
    @weakify(self);
    self.requestRemoteDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSNumber *page) {
        @strongify(self);
        return [self requestRemoteDataFromPage:page.unsignedIntegerValue];
    }];
}

- (void)handleWithDataSource:(NSArray *)dataSource {
    if (dataSource && dataSource.count > 0) {
        if (self.page == 0) {
            self.dataSource = dataSource;
        }else {
            NSMutableArray *dataSourceList = [NSMutableArray arrayWithArray:self.dataSource];
            [dataSourceList addObjectsFromArray:dataSource];
            self.dataSource = dataSourceList;
        }
        self.page ++;
    }else {
        if (self.page == 0) {
            self.dataSource = @[];
        }
    }
}

@end
