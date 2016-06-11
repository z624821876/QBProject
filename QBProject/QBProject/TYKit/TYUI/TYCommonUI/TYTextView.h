//
//  TYTextView.h
//  UEProject
//
//  Created by yanyibin on 16/4/23.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TYTextView : UITextView

/// 占位字符串
@property (nonatomic,copy) NSString *placeholder;

/// 占位符内边距
@property (nonatomic) UIEdgeInsets placeholderEdgeInsets;

/// 占位符字体
@property (nonatomic,strong) UIFont *placeholderFont;

@end
