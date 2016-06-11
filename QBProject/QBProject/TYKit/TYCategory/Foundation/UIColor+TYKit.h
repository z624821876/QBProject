//
//  UIColor+TYKit.h
//  TYKit
//
//  Created by TimothyYan on 16/2/15.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 Returns a `UIColor` instance from three individual byte values
 (i.e., `0-255` the specifying red, green and blue color components.
 */
#define UIColorFromRGBBytes(r,g,b) [UIColor \
colorWithRed:   ((CGFloat)(r)/255.0) \
green:          ((CGFloat)(g)/255.0) \
blue:           ((CGFloat)(b)/255.0) \
alpha:          1.0]

/*!
 Same as `UIColorFromRGBBytes()` but returns a `CGColorRef`
 instance instead.
 */
#define CGColorFromRGBBytes(r,g,b) UIColorFromRGBBytes(r,g,b).CGColor

/*!
 Returns a `UIColor` instance from three individual byte values
 (i.e., `0-255` the specifying red, green, blue and alpha color
 components.
 */
#define UIColorFromRGBABytes(r,g,b,a) [UIColor \
colorWithRed:   ((CGFloat)(r)/255.0) \
green:          ((CGFloat)(g)/255.0) \
blue:           ((CGFloat)(b)/255.0) \
alpha:          ((CGFloat)(a)/255.0)]

/*!
 Same as `UIColorFromRGBABytes()` but returns a `CGColorRef`
 instance instead.
 */
#define CGColorFromRGBABytes(r,g,b,a) UIColorFromRGBABytes(r,g,b,a).CGColor

/*!
 Returns a `UIColor` instance from a single 3-byte numeric value
 specifying red, green and blue color components, respectively. Typically, the
 RGB value is specified in hexadecimal notation, allowing colors to be defined
 in a manner similar to "web colors". For example, a `UIColor`
 matching the web color #f4cf51 can be created using the macro:
 `UIColorFromRGBHex(0xf4cf51)`.
 */
#define UIColorFromRGBHex(rgbValue) [UIColor \
colorWithRed:   ((CGFloat)(((rgbValue) & 0xFF0000) >> 16))/255.0 \
green:          ((CGFloat)(((rgbValue) & 0xFF00) >> 8))/255.0 \
blue:           ((CGFloat) ((rgbValue) & 0xFF))/255.0 \
alpha:          1.0]

/*!
 Same as `UIColorFromRGBHex()` but returns a `CGColorRef`
 instance instead.
 */
#define CGColorFromRGBHex(rgbValue) UIColorFromRGBHex(rgbValue).CGColor

/*!
 Returns a `UIColor` instance from a single 4-byte numeric value
 specifying red, green, blue and alpha color components, respectively. Typically,
 the RGBA value is specified in hexadecimal notation, allowing colors to be
 defined in a manner similar to "web colors". For example, a `UIColor`
 matching the web color #f4cf51 with a 50% transparency can be created using the
 macro: `UIColorFromRGBHex(0xf4cf517f)`.
 */
#define UIColorFromRGBAHex(rgbaValue) [UIColor \
colorWithRed:   ((CGFloat)(((rgbaValue) & 0xFF000000) >> 24))/255.0 \
green:          ((CGFloat)(((rgbaValue) & 0xFF0000) >> 16))/255.0 \
blue:           ((CGFloat)(((rgbaValue) & 0xFF00) >> 8))/255.0 \
alpha:          ((CGFloat) ((rgbaValue) & 0xFF))/255.0]

/*!
 Same as `UIColorFromRGBAHex()` but returns a `CGColorRef`
 instance instead.
 */
#define CGColorFromRGBAHex(rgbaValue) UIColorFromRGBAHex(rgbaValue).CGColor

@interface UIColor (TYKit)

/// 十六进制转化UIColor
+ (UIColor *)colorWithHexString:(NSString *)hexString;
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

/// 颜色转化成UIImage,尺寸为1*1
- (UIImage *)image;

/// 颜色转化成UIImage,特定的尺寸
- (UIImage *)imageWithSpecSize:(CGSize)specSize;

@end
