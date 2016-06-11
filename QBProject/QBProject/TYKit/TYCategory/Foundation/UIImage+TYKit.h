//
//  UIImage+TYKit.h
//  SmartMask
//
//  Created by TimothyYan on 16/2/20.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (TYKit)

/// 返回一个伸缩一定比例的图片
- (UIImage *)scale:(CGFloat)scale;

/// 返回一个全屏幕的截图
+ (UIImage *)screenShotImageUsingContext:(BOOL)useContext;

/// 返回高斯模糊的图片
///  1.白色,参数:
///  透明度 0~1,0为白,1为深灰色
///  半径:默认30,推荐值3,半径值越大越模糊 ,值越小越清楚
///  色彩饱和度(浓度)因子:0是黑白灰, 9是浓彩色, 1是原色  默认1.8
///  “彩度”，英文是称Saturation，即饱和度。将无彩色的黑白灰定为0，最鲜艳定为9s，这样大致分成十阶段，让数值和人的感官直觉一致。
- (UIImage *)imageBlurredImageWithRadius:(CGFloat)blurRadius
                              tintColor:(UIColor *)tintColor
                  saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                              maskImage:(UIImage *)maskImage;

/// 返回一个旋转后的图片
- (UIImage *)rotateImageWithDegrees:(CGFloat)degrees;

@end
