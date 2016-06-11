//
//  TYHTTPProgressBar.m
//  UEProject
//
//  Created by QuincyYan on 16/5/10.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import "TYHTTPProgressBar.h"

@interface TYHTTPProgressBar()
/// 最大的行进距离
@property (nonatomic) CGFloat maxProgressingProgress;
/// 未结束的时候,当前的时间
@property (nonatomic) NSTimeInterval progressingTimeInterval;
/// 未结束的时候,可变化的最大的时间
@property (nonatomic) NSTimeInterval maxProgressTimeInterval;
/// 未结束的时候的定时器
@property (nonatomic,strong) CADisplayLink *progressLink;
/// 是否是要结束
@property (nonatomic) BOOL isReadyToFinish;
/// 结束的时候,当前的时间
@property (nonatomic) NSTimeInterval finishTimeInterval;
/// 结束的时候,可变化的最大时间
@property (nonatomic) NSTimeInterval maxFinishTimeInterval;
/// 结束的时候的定时器
@property (nonatomic,strong) CADisplayLink *finishLink;

@end

@implementation TYHTTPProgressBar

- (instancetype)init {
    if (self!=[super init]) {
        return nil;
    }
    self.backgroundColor = [UIColor clearColor];
    
    self.maxProgressTimeInterval = 5;
    self.maxFinishTimeInterval = 0.5f;
    self.maxProgressingProgress = 0.7 + (arc4random_uniform(20) - 10) / 100;
    self.isReadyToFinish = NO;
    
    return self;
}

- (void)startProgressing {
    [self setHidden:NO];
    self.progressingTimeInterval = 0;
    self.isReadyToFinish = NO;
    self.progressLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(progressLinkHandler)];
    [self.progressLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)stopProgressing {
    if (self.progressLink) {
        [self.progressLink invalidate]; self.progressLink = nil;
    }
    self.finishTimeInterval = 0;
    self.isReadyToFinish = YES;
    self.finishLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(finishLinkHandler)];
    [self.finishLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)progressLinkHandler {
    self.progressingTimeInterval ++;
    [self setNeedsDisplay];
    if (self.progressingTimeInterval >= self.maxProgressTimeInterval * 60) {
        [self.progressLink invalidate]; self.progressLink = nil;
    }
}

- (void)finishLinkHandler {
    self.finishTimeInterval ++;
    [self setNeedsDisplay];
    if (self.finishTimeInterval >= self.maxFinishTimeInterval * 60) {
        [self setHidden:YES];
        [self.finishLink invalidate]; self.finishLink = nil;
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    if (self.progressLink) {
        [self.progressLink invalidate]; self.progressLink = nil;
    }
    
    if (self.finishLink) {
        [self.finishLink invalidate]; self.finishLink = nil;
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGFloat selfW = CGRectGetWidth(self.frame);
    CGFloat selfH = CGRectGetHeight(self.frame);

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, selfH);
    CGContextSetStrokeColorWithColor(context, UIColorFromRGBBytes(31, 188, 210).CGColor);
    CGFloat x = 0;
    
    if (self.isReadyToFinish) {
        CGFloat restW = selfW - selfW * self.maxProgressingProgress;
        x = selfW * self.maxProgressingProgress + restW * (self.finishTimeInterval / 60 / self.maxFinishTimeInterval);
    }else {
        x = sqrt(self.progressingTimeInterval / 60 / self.maxProgressTimeInterval) * (selfW * self.maxProgressingProgress);
    }
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, x, 0);
    CGContextStrokePath(context);
}

@end
