//
//  UIColor+KLExtension.h
//  KLCategory
//
//  Created by Logic on 2019/11/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (KLExtension)

/** @brief 随机染色 */
+ (UIColor *)kl_randomColor;

/**
 * @brief 十六进制值转颜色，支持6位或8位十六进制字符串
 * @param hexString 十六进制字符串 @"0xFFFFFF" @"#FFFFFF" @"FFFFFF"
 */
+ (UIColor *)kl_colorWithHexString:(NSString *)hexString;
+ (UIColor *)kl_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

/**
 * @brief 十六进制值转颜色，支持6位十六进制数字
 * @param hexNumber 十六进制数字 0xFFFFFF
 */
+ (UIColor *)kl_colorWithHexNumber:(unsigned int)hexNumber;
+ (UIColor *)kl_colorWithHexNumber:(unsigned int)hexNumber alpha:(CGFloat)alpha;

/**
* @brief RGB值初始化一个颜色
* @param red 动态参数，依次r,g,b,a
* @discussion 固定RGBA 4个参数，缺一不可，参数类型必须为CGFloat
* 例：[UIColor kl_colorWithRGBA:255.0, 255.0, 255.0, 1.0, nil];
*/
+ (UIColor *)kl_colorWithRGBA:(CGFloat)red, ... NS_REQUIRES_NIL_TERMINATION;

@end

NS_ASSUME_NONNULL_END
