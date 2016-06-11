//
//  TYTextView.m
//  UEProject
//
//  Created by yanyibin on 16/4/23.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import "TYTextView.h"

@implementation TYTextView

- (instancetype)init {
    if (self!=[super init]) {
        return nil;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TYTextDidChanged:) name:UITextViewTextDidChangeNotification object:nil];
    return self;
}

- (void)TYTextDidChanged:(UITextView *)textView {
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (!self.placeholder) {
        return;
    }
    
    if (self.text.length > 0) {
        return;
    }
    
    NSDictionary *placeholderAttribute = @{NSForegroundColorAttributeName:[[UIColor blackColor] colorWithAlphaComponent:0.4f],
                                           NSFontAttributeName:[UIFont systemFontOfSize:15]};
    CGSize placeholderSize = [self.placeholder boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.frame) - self.textContainerInset.left - self.textContainerInset.right, MAXFLOAT)
                                                            options:NSStringDrawingUsesLineFragmentOrigin
                                                         attributes:placeholderAttribute
                                                            context:nil].size;
    
    [self.placeholder drawInRect:CGRectMake(self.textContainerInset.left + 5,
                                            self.textContainerInset.top,
                                            CGRectGetWidth(self.frame) - self.textContainerInset.left - self.textContainerInset.right,
                                            placeholderSize.width)
                  withAttributes:placeholderAttribute];
}

@end
