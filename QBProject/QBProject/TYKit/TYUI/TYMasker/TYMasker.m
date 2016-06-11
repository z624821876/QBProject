//
//  TYMasker.m
//  TYKit
//
//  Created by QuincyYan on 16/4/10.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import "TYMasker.h"

@interface TYMasker()
@property (nonatomic,strong) NSTimer *delayTimer;

@end

@implementation TYMasker{
    /// 头部空间内边距
    UIEdgeInsets _toperEdgeInsets;
    /// 头部控件尺寸
    CGSize _topLayerSize;
    /// 文字控件内边距
    UIEdgeInsets _textEdgeInsets;
    /// 文字最大宽度
    CGFloat _maxTextWidth;
    /// 控件最小宽度
    CGFloat _minMaskerWidth;
}

- (instancetype)init {
    if (self!=[super init]) {
        return nil;
    }
    [self addSubview:self.maskerView];
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self!=[super initWithFrame:CGRectZero]) {
        return nil;
    }
    [self addSubview:self.maskerView];
    return self;
}

+(void)showMaskerWithCoverTypeContainsScripts:(NSString *)scripts showInView:(UIView *)inView {
    [TYMasker showMaskerWithType:maskerTypeCover scripts:scripts delayTimeInterval:MAXFLOAT showInView:inView TYMaskerFinishBlock:nil];
}

+(void)showMaskerWithCoverTypeContainsScripts:(NSString *)scripts showInView:(UIView *)inView TYMaskerFinishBlock:(TYMaskerFinishBlock)block {
    [TYMasker showMaskerWithType:maskerTypeCover scripts:scripts delayTimeInterval:MAXFLOAT showInView:inView TYMaskerFinishBlock:block];
}

+(void)showMaskerWithType:(TYMaskerType)type scripts:(NSString *)scripts {
    [TYMasker showMaskerWithType:type scripts:scripts showInView:nil];
}

+(void)showMaskerWithType:(TYMaskerType)type scripts:(NSString *)scripts showInView:(UIView *)inView {
    [TYMasker showMaskerWithType:type scripts:scripts delayTimeInterval:2.0f showInView:inView TYMaskerFinishBlock:nil];
}

+(void)showMaskerWithType:(TYMaskerType)type scripts:(NSString *)scripts delayTimeInterval:(NSTimeInterval)delayTime TYMaskerFinishBlock:(TYMaskerFinishBlock)block {
    [TYMasker showMaskerWithType:type scripts:scripts delayTimeInterval:delayTime showInView:nil TYMaskerFinishBlock:block];
}

+(void)showMaskerWithType:(TYMaskerType)type scripts:(NSString *)scripts delayTimeInterval:(NSTimeInterval)delayTime showInView:(UIView *)inView TYMaskerFinishBlock:(TYMaskerFinishBlock)block {
    TYMasker *masker = [TYMasker maskerInView:inView];
    masker.maskerType = type;
    masker.maskerDetailLabel.text = scripts;
    masker.autoHiddenTimeInterval = delayTime;
    masker.completeBlock = block;
    [masker showInView:inView];
}

+ (void)hiddenMaskerInView:(UIView *)inView {
    TYMasker *masker = [TYMasker maskerInView:inView];
    [masker hidden];
}

- (void)initVitalParams {
    _toperEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15);
    _textEdgeInsets = UIEdgeInsetsMake(0, 15, 15, 15);
    _maxTextWidth = 250;
    _minMaskerWidth = 150;
    _topLayerSize = CGSizeMake(30, 30);
    
    [self.activityView stopAnimating];
    [self.maskerTopShapeLayer removeFromSuperlayer];

    [self setFrame:self.superview.bounds];
}

+ (TYMasker *)maskerInView:(UIView *)inView {
    __block TYMasker *masker;
    if (inView == nil) {
        inView = [UIApplication sharedApplication].keyWindow;
    }
    [inView.subviews enumerateObjectsUsingBlock:^(UIView * class, NSUInteger idx, BOOL *stop) {
        if ([class isKindOfClass:[TYMasker class]]) {
            masker = (TYMasker *)class;
            *stop = YES;
        }
    }];
    if (masker == nil) {
        masker = [[TYMasker alloc] init];
    }
    return masker;
}

- (void)delayTimerSchedule {
    if (_autoHiddenTimeInterval>0) {
        [_delayTimer invalidate]; _delayTimer = nil;
        _delayTimer = [NSTimer scheduledTimerWithTimeInterval:_autoHiddenTimeInterval target:self selector:@selector(delayTimerCompleteAction) userInfo:nil repeats:NO];
    }
}

- (void)delayTimerCompleteAction {
    if (self.completeBlock) {
        self.completeBlock();
    }
    [self hidden];
}

- (void)showInView:(UIView *)inView {
    if (inView) {
        [inView addSubview:self];
    }else{
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
    [self initVitalParams];
    [self analysisViewsFrame];
    [self delayTimerSchedule];
    
    [self setAlpha:0.0f];
    __weak typeof(self) wself = self;
    void (^ animateHandler)() = ^(){
        [wself setAlpha:1.0f];
    };

    [UIView animateWithDuration:0.3f animations:animateHandler completion:nil];
}

- (void)hidden {
    __weak typeof(self) wself = self;
    void (^ animateHandler)() = ^(){
        [wself setAlpha:0.0f];
    };
    
    void (^ completeHandler)(BOOL finished) = ^(BOOL finished){
        [wself removeFromSuperview];
    };
    
    [UIView animateWithDuration:0.2f animations:animateHandler completion:completeHandler];
}

- (void)analysisViewsFrame {
    CGSize detailLabelSize = CGSizeZero;
    CGSize maskerSize = CGSizeMake(_minMaskerWidth, _minMaskerWidth);
    
    if (self.maskerDetailLabel.text&&self.maskerDetailLabel.text.length>0) {
        detailLabelSize = [self.maskerDetailLabel sizeThatFits:CGSizeMake(_maxTextWidth-(_textEdgeInsets.left+_textEdgeInsets.right), MAXFLOAT)];
        if (detailLabelSize.width + _textEdgeInsets.left + _textEdgeInsets.right < _minMaskerWidth) {
            detailLabelSize.width = _minMaskerWidth - _textEdgeInsets.left - _textEdgeInsets.right;
        }else{
            maskerSize.width = detailLabelSize.width + _textEdgeInsets.left + _textEdgeInsets.right;
        }
    }
    
    /// 头部控件
    if (_maskerType!=0) {
        if (_maskerType == maskerTypeWait || _maskerType == maskerTypeCover) {
            [self.maskerView addSubview:self.activityView];
            self.activityView.frame = [self rectForTopLayerWithMaskerSize:maskerSize];
            [self.activityView startAnimating];
        }else{
            [self.maskerView.layer addSublayer:self.maskerTopShapeLayer];
            self.maskerTopShapeLayer.frame = [self rectForTopLayerWithMaskerSize:maskerSize];
            switch (_maskerType) {
                case maskerTypeSuccess:{
                    self.maskerTopShapeLayer.path = [self bezierPathForCheckSymbolWithLayerRect:self.maskerTopShapeLayer.frame andLineW:2.5f].CGPath;
                }
                    break;
                case maskerTypeFail:{
                    self.maskerTopShapeLayer.path = [self bezierPathForWrongSymbolWithLayerRect:self.maskerTopShapeLayer.frame andLineW:2.f].CGPath;
                }
                    break;
                case maskerTypeAlert:{
                    self.maskerTopShapeLayer.path = [self bezierPathForWarnSymbolWithLayerRect:self.maskerTopShapeLayer.frame andLineW:2.f].CGPath;
                }
                    break;
                    
                default:
                    break;
            }
        }
        maskerSize.height = _toperEdgeInsets.top + _toperEdgeInsets.bottom + _topLayerSize.height;
    }
    
    /// 文字控件
    if (detailLabelSize.width != 0.0f) {
        if (_maskerType == maskerTypeOnlyText) {
            _textEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15);
        }
        [self.maskerView addSubview:self.maskerDetailLabel];
        CGFloat detailTotalW = detailLabelSize.width + _textEdgeInsets.left + _textEdgeInsets.right;
        CGFloat detailX = 0;
        if (detailTotalW <= _minMaskerWidth) {
            detailX = (maskerSize.width - detailTotalW) / 2 + _textEdgeInsets.left;
        }else {
            detailX = _textEdgeInsets.left;
        }
        CGFloat detailY = (_maskerType==maskerTypeOnlyText)?_textEdgeInsets.top:_toperEdgeInsets.top+_toperEdgeInsets.bottom+_topLayerSize.height+_textEdgeInsets.top;
        self.maskerDetailLabel.frame = CGRectMake(detailX,
                                                  detailY,
                                                  detailLabelSize.width,
                                                  detailLabelSize.height);
        maskerSize.height = CGRectGetMaxY(self.maskerDetailLabel.frame) + _textEdgeInsets.bottom;
    }
    
    /// 整体
    self.maskerView.frame = CGRectMake((CGRectGetWidth(self.frame) - maskerSize.width)/2,
                                       (CGRectGetHeight(self.frame) - maskerSize.height) / 2,
                                       maskerSize.width,
                                       maskerSize.height);
    
    /// 修改整体frame
    if (_maskerType == maskerTypeCover) {
        [self setBackgroundColor:[[UIColor  blackColor] colorWithAlphaComponent:0.5f]];
        
    }else{
        [self setBackgroundColor:[UIColor clearColor]];
        [self setFrame:self.maskerView.frame];
        [self.maskerView setFrame:self.bounds];
    }
}

- (CGSize)sizeForDetailLabel{
    return [self.maskerDetailLabel sizeThatFits:CGSizeMake(_maxTextWidth-(_textEdgeInsets.left+_textEdgeInsets.right), MAXFLOAT)];
}

- (CGRect)rectForTopLayerWithMaskerSize:(CGSize)maskerSize {
    return CGRectMake((maskerSize.width - _topLayerSize.width)/2,_toperEdgeInsets.top,_topLayerSize.width,_topLayerSize.height);
}

-(UIBezierPath *)bezierPathForCheckSymbolWithLayerRect:(CGRect)layerRect andLineW:(CGFloat)lineW{
    CGSize symbolSize = CGSizeMake(22, 28);
    
    CGFloat oriX = (layerRect.size.width - symbolSize.width) / 2;
    CGFloat oriY = (layerRect.size.height - symbolSize.height) / 2;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    
    [bezierPath moveToPoint:CGPointMake(oriX, oriY + 16)];
    [bezierPath addLineToPoint:CGPointMake(oriX + 7, oriY + 23)];
    [bezierPath addLineToPoint:CGPointMake(oriX + 21, oriY + 9)];
    [bezierPath addLineToPoint:CGPointMake(oriX + 21 - lineW / 2, oriY + 9 - lineW / 2)];
    [bezierPath addLineToPoint:CGPointMake(oriX + 7, oriY + 23 - lineW)];
    [bezierPath addLineToPoint:CGPointMake(oriX + lineW / 2, oriY + 16 - lineW / 2)];
    [bezierPath closePath];
    
    return bezierPath;
}

-(UIBezierPath *)bezierPathForWrongSymbolWithLayerRect:(CGRect)layerRect andLineW:(CGFloat)lineW{
    CGSize symbolSize = CGSizeMake(13, 13);
    
    CGFloat oriX = (layerRect.size.width - symbolSize.width) / 2;
    CGFloat oriY = (layerRect.size.height - symbolSize.height) / 2;
    
    CGFloat marginX = lineW / sqrt(2.0);
    CGFloat marginY = marginX;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    
    [bezierPath moveToPoint:CGPointMake(oriX, oriY + marginY)];
    [bezierPath addLineToPoint:CGPointMake(oriX + marginX, oriY)];
    [bezierPath addLineToPoint:CGPointMake(oriX + symbolSize.width / 2, oriY + symbolSize.height / 2 - marginY)];
    [bezierPath addLineToPoint:CGPointMake(oriX + symbolSize.width - marginX, oriY)];
    [bezierPath addLineToPoint:CGPointMake(oriX + symbolSize.width, oriY + marginY)];
    [bezierPath addLineToPoint:CGPointMake(oriX + symbolSize.width / 2 + marginX, oriY + symbolSize.height / 2)];
    [bezierPath addLineToPoint:CGPointMake(oriX + symbolSize.width, oriY + symbolSize.height - marginY)];
    [bezierPath addLineToPoint:CGPointMake(oriX + symbolSize.width - marginX, oriY + symbolSize.height)];
    [bezierPath addLineToPoint:CGPointMake(oriX + symbolSize.width / 2, oriY + symbolSize.height / 2 + marginY)];
    [bezierPath addLineToPoint:CGPointMake(oriX + marginX, oriY + symbolSize.height)];
    [bezierPath addLineToPoint:CGPointMake(oriX, oriY + symbolSize.height - marginY)];
    [bezierPath addLineToPoint:CGPointMake(oriX + symbolSize.width / 2 - marginX, oriY + symbolSize.height / 2)];
    [bezierPath closePath];
    
    return bezierPath;
}

-(UIBezierPath *)bezierPathForWarnSymbolWithLayerRect:(CGRect)layerRect andLineW:(CGFloat)lineW{
    CGSize symbolSize = CGSizeMake(22, 24);
    
    CGFloat oriX = (layerRect.size.width - symbolSize.width) / 2;
    CGFloat oriY = (layerRect.size.height - symbolSize.height) / 2;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    
    [bezierPath moveToPoint:CGPointMake(oriX + symbolSize.width / 2, oriY)];
    [bezierPath addArcWithCenter:CGPointMake(oriX + symbolSize.width / 2, oriY + 6) radius:lineW startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    [bezierPath moveToPoint:CGPointMake(oriX + symbolSize.width / 2 - lineW / 2, oriY + 11)];
    [bezierPath addLineToPoint:CGPointMake(oriX + symbolSize.width / 2 + lineW / 2, oriY + 11)];
    [bezierPath addLineToPoint:CGPointMake(oriX + symbolSize.width / 2 + lineW / 2, oriY + 11 + 10)];
    [bezierPath addLineToPoint:CGPointMake(oriX + symbolSize.width / 2 - lineW / 2, oriY + 11 + 10)];
    [bezierPath closePath];
    
    return bezierPath;
}

-(void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    if (_delayTimer) {
        [_delayTimer invalidate]; _delayTimer = nil;
        [self removeFromSuperview];
    }
}

-(UIView *)maskerView {
    if (!_maskerView) {
        _maskerView = [[UIView alloc] init];
        _maskerView.clipsToBounds = YES;
        _maskerView.layer.cornerRadius = 5.f;
        _maskerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8f];
    }
    return _maskerView;
}

-(UIActivityIndicatorView *)activityView {
    if (!_activityView) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    }
    return _activityView;
}

-(UILabel *)maskerDetailLabel {
    if (!_maskerDetailLabel) {
        _maskerDetailLabel = [[UILabel alloc] init];
        _maskerDetailLabel.textColor = [UIColor whiteColor];
        _maskerDetailLabel.font = [UIFont fontWithName:@"Lao Sangam MN" size:16];
        _maskerDetailLabel.textAlignment = NSTextAlignmentCenter;
        _maskerDetailLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _maskerDetailLabel.numberOfLines = 0;
    }
    return _maskerDetailLabel;
}

-(CAShapeLayer *)maskerTopShapeLayer {
    if (!_maskerTopShapeLayer) {
        _maskerTopShapeLayer = [CAShapeLayer layer];
        _maskerTopShapeLayer.borderWidth = 2.0f;
        _maskerTopShapeLayer.fillColor = [UIColor whiteColor].CGColor;
        _maskerTopShapeLayer.borderColor = [UIColor whiteColor].CGColor;
        _maskerTopShapeLayer.cornerRadius = _topLayerSize.width/2;
        _maskerTopShapeLayer.strokeColor = [UIColor clearColor].CGColor;
        [_maskerTopShapeLayer setStrokeEnd:0.0];
    }
    return _maskerTopShapeLayer;
}

@end
