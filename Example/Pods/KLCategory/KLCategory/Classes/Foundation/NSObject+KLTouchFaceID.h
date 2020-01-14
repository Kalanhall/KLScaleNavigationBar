//
//  NSObject+KLTouchFaceID.h
//  KLCategory
//
//  Created by Logic on 2019/12/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (KLTouchFaceID)

/** 是否支持生物识别技术*/
+ (BOOL)kl_authSupport;

/// 开启指纹、面容授权验证
///
/// 使用示例
///
/// [KLLocalAuth authWithLocalizedReason:@"请按住Home键完成验证" handle:^(BOOL success, NSError * _Nonnull error) {
///    NSLog(@"success: %@ code: %@, message: %@", success ? @"YES" : @"NO", @(error.code), error.localizedDescription);
/// }];
///
/// Error.code
///
/// case LAErrorAuthenticationFailed                @"TouchID/FaceID 验证失败"
/// case LAErrorUserCancel                              @"TouchID/FaceID 被用户手动取消"
/// case LAErrorUserFallback                            @"用户不使用TouchID/FaceID,选择手动输入密码"
/// case LAErrorSystemCancel                          @"TouchID/FaceID 被系统取消 (如遇到来电,锁屏,按了Home键等)"
/// case LAErrorPasscodeNotSet                      @"TouchID/FaceID 无法启动,因为用户没有设置密码"
/// case LAErrorBiometryNotEnrolled                @"TouchID/FaceID 无法启动,因为用户没有设置TouchID/FaceID"
/// case LAErrorBiometryNotAvailable               @"TouchID/FaceID 无效"
/// case LAErrorBiometryLockout                      @"TouchID/FaceID 被锁定(连续多次验证TouchID/FaceID失败,系统需要用户手动输入密码)"
/// case LAErrorAppCancel                               @"当前软件被挂起并取消了授权 (如App进入了后台等)"
/// case LAErrorInvalidContext                          @"当前软件被挂起并取消了授权 (LAContext对象无效)"
///
/// @Param reason 指纹识别对话框提示用户的信息  例：iPhoneX系列使用FaceID -> @"请对准摄像头完成验证"，其他使用TouchID -> @"请按住Home键完成验证"，面容ID需要在info.plist 中声明 Privacy - Face ID Usage Description
/// @Param handle 识别结果回调
///
+ (void)kl_authWithLocalizedReason:(NSString *)reason handle:(void (^)(BOOL success, NSError *error))handle;

@end

NS_ASSUME_NONNULL_END
