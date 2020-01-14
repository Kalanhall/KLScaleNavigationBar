//
//  NSString+KLExtension.m
//  KLCategory
//
//  Created by Logic on 2019/12/16.
//

#import "NSString+KLExtension.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@implementation NSString (KLExtension)

// 正则表达式验证
- (BOOL)kl_isateByRegex:(NSString *)regex
{
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:self];
}

- (BOOL)kl_isMobileNumber
{
    NSString *mobileRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[0678]|18[0-9]|14[57])[0-9]{8}$";
    BOOL ret1 = [self kl_isateByRegex:mobileRegex];
    return ret1;
}

- (BOOL)kl_isEmailAddress
{
    NSString *emailRegex = @"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self kl_isateByRegex:emailRegex];
}

- (BOOL)kl_isCarNumber
{
    //车牌号:湘K-DE829 香港车牌号码:粤Z-J499港
    NSString *carRegex = @"^[\u4e00-\u9fff]{1}[a-zA-Z]{1}[-][a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fff]$";//其中\u4e00-\u9fa5表示unicode编码中汉字已编码部分，\u9fa5-\u9fff是保留部分，将来可能会添加
    return [self kl_isateByRegex:carRegex];
}

- (BOOL)kl_isMacAddress
{
    NSString * macAddRegex = @"([A-Fa-f\\d]{2}:){5}[A-Fa-f\\d]{2}";
    return  [self kl_isateByRegex:macAddRegex];
}

- (BOOL)kl_isUrl
{
    NSString *regex = @"^((http)|(https))+:[^\\s]+\\.[^\\s]*$";
    return [self kl_isateByRegex:regex];
}

- (BOOL)kl_isChinese
{
    NSString *chineseRegex = @"^[\u4e00-\u9fa5]+$";
    return [self kl_isateByRegex:chineseRegex];
}

- (BOOL)kl_isNumber
{
    NSString *regex = @"[0-9]*";
    return [self kl_isateByRegex:regex];;
}

- (BOOL)kl_isMoneyNumber
{
    NSString *regex = @"^([1-9]\\d*|0)(\\.[0-9]{1,2})?$";
    return [self kl_isateByRegex:regex];;
}

- (BOOL)kl_isPostalcode
{
    NSString *postalRegex = @"^[0-8]\\d{5}(?!\\d)$";
    return [self kl_isateByRegex:postalRegex];
}

- (BOOL)kl_isTaxNo
{
    NSString *taxNoRegex = @"[0-9]\\d{13}([0-9]|X)$";
    return [self kl_isateByRegex:taxNoRegex];
}

- (BOOL)kl_isSimpleIdentityCard
{
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    return [self kl_isateByRegex:regex2];
}

- (BOOL)kl_isIdentityCard {
    NSString *value = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    int length =0;
    if (!value) {
        return NO;
    } else {
        length = (int)value.length;
        
        if (length !=15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag =NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag = YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return false;
    }
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year = 0;
    switch (length) {
        case 15:
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            if(numberofMatch > 0) {
                return YES;
            } else {
                return NO;
            }
        case 18:
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];//测试出生日期的合法性
            } else {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value options:NSMatchingReportProgress range:NSMakeRange(0, value.length)];
            
            if(numberofMatch > 0) {
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S % 11;
                NSString *M = @"F";
                NSString *JYM = @"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)]; // 判断校验位
                NSString *test = [value substringWithRange:NSMakeRange(17,1)];
                if ([[M lowercaseString] isEqualToString:[test lowercaseString]]) {
                    return YES;// 检测ID的校验位
                } else {
                    return NO;
                }
            } else {
                return NO;
            }
        default:
            return NO;
    }
}

/** 银行卡号有效性问题Luhn算法
 *  现行 16 位银联卡现行卡号开头 6 位是 622126～622925 之间的，7 到 15 位是银行自定义的，
 *  可能是发卡分行，发卡网点，发卡序号，第 16 位是校验码。
 *  16 位卡号校验位采用 Luhm 校验方法计算：
 *  1，将未带校验位的 15 位卡号从右依次编号 1 到 15，位于奇数位号上的数字乘以 2
 *  2，将奇位乘积的个十位全部相加，再加上所有偶数位上的数字
 *  3，将加法和加上校验位能被 10 整除。
 */
- (BOOL)kl_isBankCard
{
    NSString * lastNum = [[self substringFromIndex:(self.length-1)] copy];//取出最后一位
    NSString * forwardNum = [[self substringToIndex:(self.length -1)] copy];//前15或18位
    
    NSMutableArray * forwardArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i=0; i<forwardNum.length; i++) {
        NSString * subStr = [forwardNum substringWithRange:NSMakeRange(i, 1)];
        [forwardArr addObject:subStr];
    }
    
    NSMutableArray * forwardDescArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = (int)(forwardArr.count-1); i> -1; i--) {//前15位或者前18位倒序存进数组
        [forwardDescArr addObject:forwardArr[i]];
    }
    
    NSMutableArray * arrOddNum = [[NSMutableArray alloc] initWithCapacity:0];//奇数位*2的积 < 9
    NSMutableArray * arrOddNum2 = [[NSMutableArray alloc] initWithCapacity:0];//奇数位*2的积 > 9
    NSMutableArray * arrEvenNum = [[NSMutableArray alloc] initWithCapacity:0];//偶数位数组
    
    for (int i=0; i < forwardDescArr.count; i++) {
        NSInteger num = [forwardDescArr[i] intValue];
        if (i%2) {  // 偶数位
            [arrEvenNum addObject:[NSNumber numberWithInteger:num]];
        } else {    // 奇数位
            if (num * 2 < 9) {
                [arrOddNum addObject:[NSNumber numberWithInteger:num * 2]];
            } else {
                NSInteger decadeNum = (num * 2) / 10;
                NSInteger unitNum = (num * 2) % 10;
                [arrOddNum2 addObject:[NSNumber numberWithInteger:unitNum]];
                [arrOddNum2 addObject:[NSNumber numberWithInteger:decadeNum]];
            }
        }
    }
    
    __block  NSInteger sumOddNumTotal = 0;
    [arrOddNum enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumOddNumTotal += [obj integerValue];
    }];
    
    __block NSInteger sumOddNum2Total = 0;
    [arrOddNum2 enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumOddNum2Total += [obj integerValue];
    }];
    
    __block NSInteger sumEvenNumTotal =0 ;
    [arrEvenNum enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumEvenNumTotal += [obj integerValue];
    }];
    
    NSInteger lastNumber = [lastNum integerValue];
    NSInteger luhmTotal = lastNumber + sumEvenNumTotal + sumOddNum2Total + sumOddNumTotal;
    return (luhmTotal%10 == 0) ? YES : NO;
}

- (BOOL)kl_isIPAddress
{
    NSString *regex = [NSString stringWithFormat:@"^(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})$"];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL rc = [pre evaluateWithObject:self];
    if (rc) {
        NSArray *componds = [self componentsSeparatedByString:@","];
        BOOL v = YES;
        for (NSString *s in componds) {
            if (s.integerValue > 255) {
                v = NO;
                break;
            }
        }
        return v;
    }
    return NO;
}

- (instancetype)kl_reverseString
{
    NSMutableString *string = [NSMutableString stringWithCapacity:self.length];
    for (NSInteger i = self.length-1; i >= 0; i--) {
        [string appendString:[self substringWithRange:NSMakeRange(i, 1)]];
    }
    return string;
}

- (instancetype)kl_chinessToPinyin
{
    // 将NSString装换成NSMutableString
    NSMutableString *pinyin = [self mutableCopy];
    // 将汉字转换为拼音(带音标)
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    // 去掉拼音的音标
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    // 返回最近结果
    return pinyin;
}

- (BOOL)kl_isContainChinese
{
    NSUInteger length = [self length];
    for (NSUInteger i = 0; i < length; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [self substringWithRange:range];
        const char *cString = [subString UTF8String];
        if (strlen(cString) == 3) {
            return YES;
        }
    }
    return NO;
}

+ (instancetype)kl_documentPathWithFileName:(NSString *)fileName
{
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    return [document stringByAppendingPathComponent:fileName];
}

+ (instancetype)kl_cachePathWithFileName:(NSString *)fileName
{
    NSString *cache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    return [cache stringByAppendingPathComponent:fileName];
}

+ (instancetype)kl_temptPathWithFileName:(NSString *)fileName
{
    return [NSTemporaryDirectory() stringByAppendingPathComponent:fileName];
}

- (NSString *)kl_stringWithURLEncoding
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                 (__bridge CFStringRef)[self kl_decodeURLEncoding],
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'\();:@&=+$,/?%#[] ",
                                                                                 kCFStringEncodingUTF8));
#pragma clang diagnostic pop
}

- (NSString *)kl_stringWithURLEncodingPath
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                 (__bridge CFStringRef)[self kl_decodeURLEncoding],
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'\();:@&=+$,?%#[] ",
                                                                                 kCFStringEncodingUTF8));
#pragma clang diagnostic pop
}

- (NSString *)kl_decodeURLEncoding
{
    NSString *result = [self stringByRemovingPercentEncoding];
    return result?result:self;
}

@end
