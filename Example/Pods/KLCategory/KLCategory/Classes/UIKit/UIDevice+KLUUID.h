//
//  UIDevice+KLUUID.h
//  KLCategory
//
//  Created by Logic on 2020/1/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (KLUUID)

/// Vindor标示符,适用于对内：例如分析用户在应用内的行为等。
+ (NSString *)kl_deviceIdentifier;

/// Vindor标示符  (钥匙串保存)
+ (NSString *)kl_deviceIdentifierForKeyChain;

/// Vindor标示符  (钥匙串删除)
+ (BOOL)kl_deleteDeviceIdentifierForKeyChain;

///获取CFUUID
+ (NSString *)kl_deviceCFUUID;

///获取NSUUID
+ (NSString *)kl_deviceNSUUID;

@end

NS_ASSUME_NONNULL_END
