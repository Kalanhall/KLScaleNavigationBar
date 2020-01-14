//
//  NSString+KLValue.h
//  KLCategory
//
//  Created by Logic on 2019/12/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (KLValue)

/// 返回2位有效小数
- (CGFloat)kl_decimalValue;
/// 返回2位有效小数字符串
- (NSString *)kl_decimalString;
/// 返回2位有效小数字符串
+ (NSString *)kl_decimalStringWithValue:(CGFloat)value;
/// 返回2位带格式的有效小数字符串，例：123,456,789.00
- (NSString *)kl_decimalStyleString;
/// 返回2位带格式的有效小数字符串，例：123,456,789.00
+ (NSString *)kl_decimalStyleStringWithValue:(CGFloat)value;
/// 字符串转NSNumber
- (NSNumber *)kl_numberValue;

@end

NS_ASSUME_NONNULL_END
