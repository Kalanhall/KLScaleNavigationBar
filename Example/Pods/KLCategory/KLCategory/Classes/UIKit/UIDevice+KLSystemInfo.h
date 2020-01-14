//
//  UIDevice+KLExtension.h
//  KLCategory
//
//  Created by Logic on 2019/12/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (KLSystemInfo)

/// 获取操作系统版本号
+ (NSString *)kl_systemVersion;

/// 获取操作系统版本 包括设备操作系统名称
+ (NSString *)kl_OSVersion;

/// 获取当前系统语言
+ (NSString *)kl_OSLanguage;

/// 获取App显示的名称
+ (NSString *)kl_appDisplayName;

/// 获取App的Build版本
+ (NSString *)kl_appBuildVersion;

/// 获取App的Version版本
+ (NSString *)kl_appShortVersion;

/// 获取appID BundleID 例如:com.XX.XX
+ (NSString *)kl_appIdentifier;

/// 获取当前设备名称    比如: iPad, iPhone, iPod, iPad Simulator等
+ (NSString *)kl_deviceModel;

/// 是否越狱
+ (BOOL)kl_isJailBroken NS_AVAILABLE_IOS(4_0);

/// 此方法只针对实现越狱的真机iPhone
+ (NSString *)kl_jailBreaker NS_AVAILABLE_IOS(4_0);

///获取运营商
+ (NSString *)kl_carrierName;

///获取运营商编码
+ (NSString *)kl_mobileNetworkCode;

/// 设备机型
+ (NSString *)kl_currentModel;

/// IPV4
+ (NSString *)kl_IPV4;

/// IPV6
+ (NSString *)kl_IPV6;

@end

NS_ASSUME_NONNULL_END
