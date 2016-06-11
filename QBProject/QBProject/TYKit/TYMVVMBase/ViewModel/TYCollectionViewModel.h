//
//  TYCollectionViewModel.h
//  MPProject
//
//  Created by QuincyYan on 16/6/2.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import "TYTableViewModel.h"

@interface TYCollectionViewModel : TYTableViewModel

/// 布局
@property (nonatomic,strong) UICollectionViewLayout *viewLayout;

/// 流式布局
@property (nonatomic,strong) UICollectionViewFlowLayout *viewFlowLayout;

/// 内边距
@property (nonatomic,strong) NSNumber *flowLayoutPadding;

@end
