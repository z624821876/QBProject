//
//  TYTabbarEntity.m
//  MPProject
//
//  Created by QuincyYan on 16/5/27.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import "TYTabbarEntity.h"

@implementation TYTabbarEntity

- (instancetype)init {
    if (self!=[super init]) {
        return nil;
    }
    
    [self setBackgroundColor:[UIColor clearColor]];
    [self initParams];
    
    return self;
}

- (void)setBadgeValue:(NSInteger)badgeValue {
    _badgeValue = badgeValue;
    [self setNeedsDisplay];
}

- (void)initParams {
    self.normalStateSystemFont = [UIFont systemFontOfSize:13];
    self.normalStateTextColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
    self.normalStateBackgroundColor = [UIColor whiteColor];
    
    self.selectedStateSystemFont = [UIFont systemFontOfSize:13];
    self.selectedStateTextColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
    self.selectedStateBackgroundColor = [UIColor whiteColor];
    
    self.badgeSystemFont = [UIFont systemFontOfSize:12];
    self.isOnlyDisplayRedSpot = NO;
}

- (void)drawRect:(CGRect)rect {
    CGSize selfSize = self.frame.size;
    CGSize imageSize = CGSizeMake(25, 25);
    CGSize titleSize = CGSizeZero;
    NSDictionary *currentAttribute = nil;
    UIImage *currentImage = nil;
    UIImage *currentBackgroundImage = nil;
    
    UIImage *normalStateImage = [UIImage imageNamed:self.normalStateIcon];
    UIImage *selectedStateImage = [UIImage imageNamed:self.selectedStateIcon];
    
    if (self.isSelected) {
        currentAttribute = self.selectedStateTextAttribute;
        currentImage = selectedStateImage;
        currentBackgroundImage = [self imageWithColor:self.selectedStateBackgroundColor];
    }else {
        currentAttribute = self.normalStateTextAttribute;
        currentImage = normalStateImage;
        currentBackgroundImage = [self imageWithColor:self.normalStateBackgroundColor];
    }
    
    [currentBackgroundImage drawInRect:self.bounds];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    if (self.title && self.title.length > 0) {
        titleSize = [self.title boundingRectWithSize:CGSizeMake(selfSize.width, 20)
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:currentAttribute
                                             context:nil].size;
        if (self.normalStateIcon && self.normalStateIcon.length>0) {
            [currentImage drawInRect:CGRectMake((selfSize.width - imageSize.width)/2,
                                                5,
                                                imageSize.width,
                                                imageSize.height)];
            
            [self.title drawInRect:CGRectMake((selfSize.width - titleSize.width)/2,
                                              5 + imageSize.height + 2,
                                              titleSize.width,
                                              titleSize.height)
                    withAttributes:currentAttribute];
        }else{
            [self.title drawInRect:CGRectMake((selfSize.width - titleSize.width)/2,
                                              (selfSize.height - titleSize.height)/2,
                                              titleSize.width,
                                              titleSize.height)
                    withAttributes:currentAttribute];
        }
    }else {
        [currentImage drawInRect:self.bounds];
    }
    
    ///角标
    if (self.badgeValue) {
        CGSize badgeSize = CGSizeZero;
        CGRect badgeRect = CGRectZero;
        CGFloat offset = 3.0f;
        CGFloat padding = 3.0f;
        
        if (self.isOnlyDisplayRedSpot) {
            CGContextSetFillColorWithColor(context, [[UIColor redColor] CGColor]);
            CGContextFillEllipseInRect(context, CGRectMake(selfSize.width / 2 + 12,
                                                           3,
                                                           8,
                                                           8));
        }else {
            NSString *badge = [NSString stringWithFormat:@"%d",(int)self.badgeValue];
            badgeSize = [badge boundingRectWithSize:CGSizeMake(selfSize.width, 23)
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:@{NSFontAttributeName:self.badgeSystemFont}
                                            context:nil].size;
            
            if (badgeSize.width < badgeSize.height) {
                badgeSize = CGSizeMake(badgeSize.height, badgeSize.height);
            }
            
            badgeRect = CGRectMake(selfSize.width - badgeSize.width - 2 * offset - padding,
                                   padding,
                                   badgeSize.width + 2 * offset,
                                   badgeSize.height + 2 * offset);
            
            CGContextSetFillColorWithColor(context, [[UIColor redColor] CGColor]);
            CGContextFillEllipseInRect(context, badgeRect);
            
            NSMutableParagraphStyle *badgeTextStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
            [badgeTextStyle setLineBreakMode:NSLineBreakByCharWrapping];
            [badgeTextStyle setAlignment:NSTextAlignmentCenter];
            
            [badge drawInRect:CGRectMake(CGRectGetMinX(badgeRect),
                                         CGRectGetMinY(badgeRect) + offset,
                                         badgeRect.size.width,
                                         badgeRect.size.height)
               withAttributes:@{NSFontAttributeName:self.badgeSystemFont,
                                NSForegroundColorAttributeName:[UIColor whiteColor],
                                NSParagraphStyleAttributeName:badgeTextStyle}];
        }
    }
    
    CGContextRestoreGState(context);
}

- (UIImage *)imageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (NSDictionary *)normalStateTextAttribute {
    NSMutableDictionary *attribute = [[NSMutableDictionary alloc] init];
    [attribute setValue:self.normalStateSystemFont forKey:NSFontAttributeName];
    [attribute setValue:self.normalStateTextColor forKey:NSForegroundColorAttributeName];
    return attribute;
}

- (NSDictionary *)selectedStateTextAttribute {
    NSMutableDictionary *attribute = [[NSMutableDictionary alloc] init];
    [attribute setValue:self.selectedStateSystemFont forKey:NSFontAttributeName];
    [attribute setValue:self.selectedStateTextColor forKey:NSForegroundColorAttributeName];
    return attribute;
}

@end
