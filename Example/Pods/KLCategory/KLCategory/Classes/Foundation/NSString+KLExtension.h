//
//  NSString+KLExtension.h
//  KLCategory
//
//  Created by Logic on 2019/12/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (KLExtension)

/// MARK: - 常用验证
/// 手机号有效性
- (BOOL)kl_isMobileNumber;
///邮箱的有效性
- (BOOL)kl_isEmailAddress;
/// 车牌号的有效性
- (BOOL)kl_isCarNumber;
/// 银行卡的有效性
- (BOOL)kl_isBankCard;
/// IP地址有效性
- (BOOL)kl_isIPAddress;
/// Mac地址有效性
- (BOOL)kl_isMacAddress;
/// 网址有效性
- (BOOL)kl_isUrl;
/// 是否纯汉字
- (BOOL)kl_isChinese;
/// 是否纯数字
- (BOOL)kl_isNumber;
/// 是否是金额，最多2位小数
- (BOOL)kl_isMoneyNumber;
/// 邮政编码
- (BOOL)kl_isPostalcode;
/// 工商税号
- (BOOL)kl_isTaxNo;
/// 简单的身份证有效性
- (BOOL)kl_isSimpleIdentityCard;
/// 精确身份证有效验证
- (BOOL)kl_isIdentityCard;

/// 字符串反转
- (instancetype)kl_reverseString;
/// 汉字转拼音
- (instancetype)kl_chinessToPinyin;
/// 是否包含中文
- (BOOL)kl_isContainChinese;

/// MARK: - 沙盒相关
/// 沙盒 - Document
+ (instancetype)kl_documentPathWithFileName:(NSString *)fileName;
/// 沙盒 - Cache
+ (instancetype)kl_cachePathWithFileName:(NSString *)fileName;
/// 沙盒 - Temp
+ (instancetype)kl_temptPathWithFileName:(NSString *)fileName;

/// MARK: - 过滤相关
/// 特殊字符过虑
- (NSString *)kl_stringWithURLEncoding;
/// 特殊字符过虑
- (NSString *)kl_stringWithURLEncodingPath;

@end

NS_ASSUME_NONNULL_END
