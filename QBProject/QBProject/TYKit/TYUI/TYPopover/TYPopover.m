//
//  TYDisplayer.m
//  TYKit
//
//  Created by QuincyYan on 16/4/10.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import "TYPopover.h"

#define _UIKeyboardFrameEndUserInfoKey (&UIKeyboardFrameEndUserInfoKey != NULL ? UIKeyboardFrameEndUserInfoKey : @"UIKeyboardBoundsUserInfoKey")

@interface TYPopover()
@property (nonatomic,strong) NSMutableArray *innerButtonsList;
@property (nonatomic,strong) UIView *innerButtonsBackgroundView;
@property (nonatomic,strong) UIView *popoverBackgroundView;

@end

@implementation TYPopover

- (instancetype)init {
    if (self!=[super init]) {
        return nil;
    }
    
    [self addSubview:self.popoverBackgroundView];
    
    UITapGestureRecognizer *tapHandler = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(popoverHiddenHandler)];
    [self.popoverBackgroundView addGestureRecognizer:tapHandler];
    self.popoverBackgroundView.userInteractionEnabled = YES;
    
    _popoverDefaultWidth = 250;
    _popoverButtonHeight = 50;
    _popoverTitleEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15);
    /// 如果没有标题,上部内边距定为15
    _popoverDetailsEdgeInsets = UIEdgeInsetsMake(0, 15, 15, 15);
    
    _isHiddenCancelButton = NO;
    _isHiddenPopoverWithTouch = NO;
    _isBanHiddenPopoverWithButton = NO;
    _isForceButtonsFlowArrange = NO;
    _isPopoverStillAlive = NO;
    
    _popoverPositionType = TYPopoverPositionTypeCenter;
    _popoverContentType = TYPopoverContentTypeCommon;
    
    return self;
}

+ (TYPopover *)showPopoverWithTitle:(NSString *)title detailsText:(NSString *)detailsText cancelButtonTitle:(NSString *)cancelButtonTitle otherButtons:(NSArray *)otherButtons completeHandler:(TYPopoverHandler)handler {
    TYPopover *popover = [[TYPopover alloc] init];
    popover.popoverTitleLabel.text = title;
    popover.popoverDetailsLabel.text = detailsText;
    popover.popoverButtons = otherButtons;
    if (cancelButtonTitle && cancelButtonTitle.length > 0) {
        [popover.popoverCancelButton setTitle:cancelButtonTitle forState:0];
    }else {
        popover.isHiddenCancelButton = YES;
    }
    popover.handler = handler;
    [popover showPopoverInView:[UIApplication sharedApplication].keyWindow];
    
    return popover;
}

+ (TYPopover *)showSheetPopoverWithTitle:(NSString *)title detailsText:(NSString *)detailsText otherButtons:(NSArray *)otherButtons completeHandler:(TYPopoverHandler)handler {
    TYPopover *popover = [[TYPopover alloc] init];
    popover.popoverTitleLabel.text = title;
    popover.popoverDetailsLabel.text = detailsText;
    popover.popoverButtons = otherButtons;
    popover.popoverPositionType = TYPopoverPositionTypeBottom;
    popover.isHiddenCancelButton = YES;
    popover.handler = handler;
    [popover showPopoverInView:[UIApplication sharedApplication].keyWindow];
    
    return popover;
}

+ (TYPopover *)showPopoverWithCustomView:(UIView *)popoverCustomView customRect:(CGRect)popoverCustomRect {
    TYPopover *popover = [[TYPopover alloc] init];
    [popover setBackgroundColor:[UIColor clearColor]];
    [popover.popoverView setBackgroundColor:[UIColor clearColor]];
    popover.popoverContentType = TYPopoverContentTypeCustom;
    popover.isHiddenPopoverWithTouch = YES;
    popover.isHiddenCancelButton = YES;
    popover.popoverCustomView = popoverCustomView;
    popover.popoverCustomView.frame = popoverCustomRect;
    [popover showPopoverInView:[UIApplication sharedApplication].keyWindow];
    
    return popover;
}

+ (TYPopover *)showPopoverWithCustomView:(UIView *)popoverCustomView customRect:(CGRect)popoverCustomRect otherButtons:(NSArray *)otherButtons completeHandler:(TYPopoverHandler)handler {
    TYPopover *popover = [[TYPopover alloc] init];
    popover.popoverContentType = TYPopoverContentTypeCustom;
    popover.isHiddenCancelButton = YES;
    popover.popoverCustomView = popoverCustomView;
    popover.popoverCustomView.frame = popoverCustomRect;
    popover.popoverButtons = otherButtons;
    popover.handler = handler;
    [popover showPopoverInView:[UIApplication sharedApplication].keyWindow];
    
    return popover;
}

+ (TYPopover *)showPopoverWithButtons:(NSArray *)buttons completeHandler:(TYPopoverHandler)handler {
    TYPopover *popover = [[TYPopover alloc] init];
    popover.popoverButtons = buttons;
    popover.isHiddenCancelButton = YES;
    popover.isForceButtonsFlowArrange = YES;
    popover.isHiddenPopoverWithTouch = YES;
    popover.popoverDefaultWidth = [UIScreen mainScreen].bounds.size.width - 40;
    popover.popoverButtonHeight = 50;
    popover.handler = handler;
    [popover showPopoverInView:[UIApplication sharedApplication].keyWindow];
    
    return popover;
}

+ (void)hiddenPopoverInView:(UIView *)inView {
    for (UIView *view in inView.subviews) {
        if ([view isKindOfClass:[TYPopover class]]) {
            [(TYPopover *)view hiddenPopover];
        }
    }
}

/// 键盘响应
- (void)initNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TYPopover_KeyBoardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TYPopover_KeyBoardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)TYPopover_KeyBoardWillShowNotification:(NSNotification *)notification {
    CGRect keyboardRect = [self convertRect:[[[notification userInfo] objectForKey:_UIKeyboardFrameEndUserInfoKey] CGRectValue] fromView:nil];
    if (CGRectIsEmpty(keyboardRect)) {
        return;
    }
    UIView *responseHandler = [self responseHandlerInView:self.popoverView];
    CGRect handlerRect = CGRectZero;
    CGFloat willMoveHeight = 0;
    if (responseHandler) {
        handlerRect = [self.popoverView convertRect:responseHandler.frame toView:self];
        willMoveHeight = [self handlerWillMoveWithKeyboardHeight:keyboardRect.size.height handlerRect:handlerRect];
        __weak typeof(self) wself = self;
        void (^ animationBlock)() = ^(){
            wself.popoverView.frame = CGRectMake(CGRectGetMinX(wself.popoverView.frame),
                                                 (CGRectGetHeight(wself.frame) - CGRectGetHeight(wself.popoverView.frame))/2 + willMoveHeight,
                                                 CGRectGetWidth(wself.popoverView.frame),
                                                 CGRectGetHeight(wself.popoverView.frame));
        };
        [UIView animateWithDuration:0.2f animations:animationBlock];
    }
}

-(CGFloat)handlerWillMoveWithKeyboardHeight:(CGFloat)keyBoardHeight handlerRect:(CGRect)handlerRect{
    CGFloat bottomY = CGRectGetHeight(self.frame) - handlerRect.size.height - handlerRect.origin.y;
    CGFloat willMoveHeight = bottomY - keyBoardHeight - 20;
    if (willMoveHeight > 0) {
        return 0;
    }
    return willMoveHeight;
}

- (void)TYPopover_KeyBoardWillHideNotification:(NSNotification *)notification {
    __weak typeof(self) wself = self;
    void (^ animationBlock)() = ^(){
        wself.popoverView.frame = CGRectMake(CGRectGetMinX(wself.popoverView.frame),
                                             (CGRectGetHeight(wself.frame) - CGRectGetHeight(wself.popoverView.frame))/2,
                                             CGRectGetWidth(wself.popoverView.frame),
                                             CGRectGetHeight(wself.popoverView.frame));
    };
    [UIView animateWithDuration:0.2f animations:animationBlock];
}

- (UIView *)responseHandlerInView:(UIView *)inView {
    for (UIView *subView in inView.subviews) {
        if ([subView isFirstResponder]) {
            return subView;
        }
        UIView *resultView = [self responseHandlerInView:subView];
        if (resultView) {
            return resultView;
        }
    }
    return nil;
}

- (void)showPopoverInView:(UIView *)inView {
    [inView addSubview:self];
    [self setFrame:inView.bounds];
    [self addSubview:self.popoverView];
    
    if (_popoverContentType == TYPopoverContentTypeCustom) {
        UITapGestureRecognizer *tapHandler = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(popoverViewHandler)];
        [self.popoverView addGestureRecognizer:tapHandler];
        self.popoverView.userInteractionEnabled = YES;
        [self initNotifications];
    }
    [self.popoverBackgroundView setFrame:self.bounds];
    
    if (_popoverPositionType == TYPopoverPositionTypeBottom) {
        _popoverDefaultWidth = CGRectGetWidth(inView.frame);
    }
    
    [self handlePopoverButtons];
    [self handlePopoverCornerRadius];
    [self analysisViewsFrame];
    [self handleEnterAnimation];
    self.isPopoverStillAlive = YES;
}

- (void)hiddenPopover {
    [self handleExitAnimation];
}

- (void)popoverHiddenHandler {
    if (_isHiddenPopoverWithTouch) {
        [self hiddenPopover];
    }
}

- (void)popoverViewHandler {
    [[self responseHandlerInView:self.popoverView] resignFirstResponder];
}

- (void)analysisViewsFrame {
    CGSize titleSize = CGSizeZero;
    CGSize detailsSize = CGSizeZero;
    CGFloat viewsTotalHeight = 0;
    CGFloat buttonPadding = 0.5f;
    CGFloat buttonWidth = 0.0f;
    CGFloat buttonViewFullWidth = 0.0f;
    BOOL isButtonsInSingleLine = self.innerButtonsList.count == 2 && self.popoverPositionType != TYPopoverPositionTypeBottom && !_isForceButtonsFlowArrange;
    
    switch (self.popoverContentType) {
        case TYPopoverContentTypeCommon:{
            buttonViewFullWidth = _popoverDefaultWidth;
            if (isButtonsInSingleLine) {
                buttonWidth = (_popoverDefaultWidth - buttonPadding)/2;
            }else {
                buttonWidth = _popoverDefaultWidth;
            }
            /// 标题
            if (self.popoverTitleLabel.text&&self.popoverTitleLabel.text.length>0) {
                titleSize = [self.popoverTitleLabel sizeThatFits:CGSizeMake((_popoverDefaultWidth-_popoverTitleEdgeInsets.left-_popoverTitleEdgeInsets.right), MAXFLOAT)];
                [self.popoverView addSubview:self.popoverTitleLabel];
                [self.popoverTitleLabel setFrame:CGRectMake(_popoverTitleEdgeInsets.left,
                                                            _popoverTitleEdgeInsets.top,
                                                            _popoverDefaultWidth - _popoverTitleEdgeInsets.left - _popoverTitleEdgeInsets.right,
                                                            titleSize.height)];
                viewsTotalHeight = CGRectGetMaxY(self.popoverTitleLabel.frame) + _popoverTitleEdgeInsets.bottom;
            }
            
            /// 内容
            if (self.popoverDetailsLabel.text&&self.popoverDetailsLabel.text.length>0) {
                detailsSize = [self.popoverDetailsLabel sizeThatFits:CGSizeMake((_popoverDefaultWidth-_popoverDetailsEdgeInsets.left-_popoverDetailsEdgeInsets.right), MAXFLOAT)];
                [self.popoverView addSubview:self.popoverDetailsLabel];
                if (titleSize.height==0) {
                    [self.popoverDetailsLabel setFrame:CGRectMake(_popoverDetailsEdgeInsets.left,
                                                                  15,
                                                                  _popoverDefaultWidth - _popoverDetailsEdgeInsets.left - _popoverDetailsEdgeInsets.right,
                                                                  detailsSize.height)];
                }else{
                    [self.popoverDetailsLabel setFrame:CGRectMake(_popoverDetailsEdgeInsets.left,
                                                                  _popoverTitleEdgeInsets.top + titleSize.height + _popoverTitleEdgeInsets.bottom,
                                                                  _popoverDefaultWidth - _popoverDetailsEdgeInsets.left - _popoverDetailsEdgeInsets.right,
                                                                  detailsSize.height)];
                }
                viewsTotalHeight = CGRectGetMaxY(self.popoverDetailsLabel.frame) + _popoverDetailsEdgeInsets.bottom;
            }
        }
            break;
        case TYPopoverContentTypeCustom:{
            buttonViewFullWidth = CGRectGetWidth(self.popoverCustomView.frame);
            if (isButtonsInSingleLine) {
                buttonWidth = (CGRectGetWidth(self.popoverCustomView.frame) - buttonPadding) / 2;
            }else {
                buttonWidth = CGRectGetWidth(self.popoverCustomView.frame);
            }
            viewsTotalHeight = CGRectGetHeight(self.popoverCustomView.frame);
            [self.popoverView addSubview:self.popoverCustomView];
        }
            break;
            
        default:
            break;
    }
    
    /// 按钮
    if (self.innerButtonsList.count > 0) {
        [self.popoverView addSubview:self.innerButtonsBackgroundView];
        [self.innerButtonsBackgroundView setFrame:CGRectMake(0,
                                                             viewsTotalHeight,
                                                             buttonViewFullWidth,
                                                             isButtonsInSingleLine ?_popoverButtonHeight:(_popoverButtonHeight+buttonPadding)*self.innerButtonsList.count)];
        [self.innerButtonsList enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL * stop) {
            [button setTag:idx];
            [button addTarget:self action:@selector(popoverButtonHandler:) forControlEvents:UIControlEventTouchUpInside];
            [self.innerButtonsBackgroundView addSubview:button];
            if (isButtonsInSingleLine) {
                [button setFrame:CGRectMake((buttonPadding / 2 + buttonWidth)*idx,
                                            buttonPadding,
                                            buttonWidth,
                                            _popoverButtonHeight-buttonPadding)];
            }else {
                [button setFrame:CGRectMake(0,
                                            buttonPadding + _popoverButtonHeight*idx,
                                            buttonWidth,
                                            _popoverButtonHeight-buttonPadding)];
            }
        }];
        viewsTotalHeight += CGRectGetHeight(self.innerButtonsBackgroundView.frame) - 2*buttonPadding;
    }
    
    /// 主控件
    switch (self.popoverContentType) {
        case TYPopoverContentTypeCommon:{
            [self.popoverView setFrame:CGRectMake((CGRectGetWidth(self.frame) - _popoverDefaultWidth)/2,
                                                  _popoverPositionType == TYPopoverPositionTypeBottom ? CGRectGetHeight(self.frame) : (CGRectGetHeight(self.frame)-viewsTotalHeight)/2,
                                                  _popoverDefaultWidth,
                                                  viewsTotalHeight)];
        }
            break;
        case TYPopoverContentTypeCustom:{
            [self.popoverView setFrame:CGRectMake((CGRectGetWidth(self.frame) - CGRectGetWidth(self.popoverCustomView.frame)) / 2,
                                                  (CGRectGetHeight(self.frame) - viewsTotalHeight) / 2,
                                                  CGRectGetWidth(self.popoverCustomView.frame),
                                                  viewsTotalHeight)];
        }
            break;
        default:
            break;
    }
}

- (void)handlePopoverButtons {
    self.innerButtonsList = [[NSMutableArray alloc] init];
    for (id obj in self.popoverButtons) {
        if ([obj isKindOfClass:[NSString class]]) {
            UIButton *normalButton = [self normalButton];
            [normalButton setTitle:obj forState:0];
            [self.innerButtonsList addObject:normalButton];
        }else if ([obj isKindOfClass:[UIButton class]]) {
            [self.innerButtonsList addObject:obj];
        }
    }
    
    if (!self.isHiddenCancelButton) {
        if (self.innerButtonsList.count == 1 && self.popoverPositionType != TYPopoverPositionTypeBottom) {
            [self.innerButtonsList insertObject:self.popoverCancelButton atIndex:0];
        }else{
            [self.innerButtonsList addObject:self.popoverCancelButton];
        }
    }
}

- (void)handlePopoverCornerRadius {
    switch (_popoverPositionType) {
        case TYPopoverPositionTypeCenter:{
            self.popoverView.layer.cornerRadius = 8.0f;
        }
            break;
        case TYPopoverPositionTypeBottom:{
            self.popoverView.layer.cornerRadius = 0.0f;
        }
            break;
        default:
            break;
    }
}

- (void)handleEnterAnimation {
    __weak typeof(self) wself = self;
    switch (_popoverPositionType) {
        case TYPopoverPositionTypeCenter:{
            [wself.popoverView setAlpha:0.0f];
            void (^ animateHandler)() = ^(){
                [wself.popoverView setAlpha:1.0f];
            };
            
            [UIView animateWithDuration:0.2f animations:animateHandler completion:nil];
        }
            break;
        case TYPopoverPositionTypeBottom:{
            void (^ animateHandler)() = ^(){
                [wself.popoverView setTransform:CGAffineTransformMakeTranslation(0, -CGRectGetHeight(wself.popoverView.frame))];
            };
            
            [UIView animateWithDuration:0.2f animations:animateHandler completion:nil];
        }
            break;
        default:
            break;
    }
}

- (void)handleExitAnimation {
    __weak typeof(self) wself = self;
    switch (_popoverPositionType) {
        case TYPopoverPositionTypeCenter:{
            [wself removeFromSuperview];
        }
            break;
        case TYPopoverPositionTypeBottom:{
            void (^ animateHandler)() = ^(){
                [wself.popoverView setTransform:CGAffineTransformIdentity];
            };
            
            void (^ completeHandler)(BOOL finished) = ^(BOOL finished){
                [wself removeFromSuperview];
            };
            
            [UIView animateWithDuration:0.2f animations:animateHandler completion:completeHandler];
        }
            break;
        default:
            break;
    }
    _isPopoverStillAlive = NO;
}

- (void)popoverButtonHandler:(UIButton *)sender {
    if (self.handler) {
        self.handler(sender.tag);
    }
    
    if (!self.isBanHiddenPopoverWithButton) {
        [self hiddenPopover];
    }
}

- (UIButton *)popoverCancelButton {
    if (!_popoverCancelButton) {
        _popoverCancelButton = [[UIButton alloc] init];
        [_popoverCancelButton setTitle:@"取消" forState:0];
        [_popoverCancelButton setBackgroundImage:[UIColor whiteColor].popoverColorImage forState:0];
        [_popoverCancelButton setBackgroundImage:[UIColor colorWithWhite:0.95 alpha:1.0f].popoverColorImage forState:UIControlStateHighlighted];
        [_popoverCancelButton setTitleColor:[UIColor colorWithRed:31.0/255.0 green:186.0/255.0 blue:186.0/255.0 alpha:1.0f] forState:0];
        [_popoverCancelButton.titleLabel setFont:[UIFont fontWithName:@"Lao Sangam MN" size:16]];
    }
    return _popoverCancelButton;
}

- (UIButton *)normalButton {
    UIButton *normalButton = [[UIButton alloc] init];
    [normalButton setBackgroundColor:[UIColor whiteColor]];
    [normalButton setTitleColor:[UIColor colorWithRed:32.0/255.0 green:41.0/255.0 blue:50.0/255.0 alpha:1.0f] forState:0];
    [normalButton.titleLabel setFont:[UIFont fontWithName:@"Lao Sangam MN" size:16]];
    [normalButton setBackgroundImage:[UIColor whiteColor].popoverColorImage forState:0];
    [normalButton setBackgroundImage:[UIColor colorWithWhite:0.95 alpha:1.0f].popoverColorImage forState:UIControlStateHighlighted];
    return normalButton;
}

- (UIView *)popoverView {
    if (!_popoverView) {
        _popoverView = [[UIView alloc] init];
        _popoverView.clipsToBounds = YES;
        _popoverView.backgroundColor = [UIColor whiteColor];
    }
    return _popoverView;
}

-(UIView *)popoverBackgroundView {
    if (!_popoverBackgroundView) {
        _popoverBackgroundView = [[UIView alloc] init];
        [_popoverBackgroundView setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5f]];
    }
    return _popoverBackgroundView;
}

-(UIView *)innerButtonsBackgroundView {
    if (!_innerButtonsBackgroundView) {
        _innerButtonsBackgroundView = [[UIView alloc] init];
        _innerButtonsBackgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3f];
    }
    return _innerButtonsBackgroundView;
}

-(UILabel *)popoverTitleLabel {
    if (!_popoverTitleLabel) {
        _popoverTitleLabel = [[UILabel alloc] init];
        _popoverTitleLabel.backgroundColor = [UIColor clearColor];
        _popoverTitleLabel.textAlignment = NSTextAlignmentCenter;
        _popoverTitleLabel.font = [UIFont fontWithName:@"Lao Sangam MN" size:15];
        _popoverTitleLabel.numberOfLines = 0;
        _popoverTitleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    }
    return _popoverTitleLabel;
}

-(UILabel *)popoverDetailsLabel {
    if (!_popoverDetailsLabel) {
        _popoverDetailsLabel = [[UILabel alloc] init];
        _popoverDetailsLabel.backgroundColor = [UIColor clearColor];
        _popoverDetailsLabel.font = [UIFont fontWithName:@"Lao Sangam MN" size:15];
        _popoverDetailsLabel.numberOfLines = 0;
        _popoverDetailsLabel.textAlignment = NSTextAlignmentCenter;
        _popoverDetailsLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _popoverDetailsLabel.textColor = [UIColor colorWithRed:32.0/255.0 green:41.0/255.0 blue:50.0/255.0 alpha:1.0f];
    }
    return _popoverDetailsLabel;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end





@implementation UIColor (TYPopover)

-(UIImage *)popoverColorImage{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
