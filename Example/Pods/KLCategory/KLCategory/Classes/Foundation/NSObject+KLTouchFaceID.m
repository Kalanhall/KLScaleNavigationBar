//
//  NSObject+KLTouchFaceID.m
//  KLCategory
//
//  Created by Logic on 2019/12/2.
//

#import "NSObject+KLTouchFaceID.h"
#import <LocalAuthentication/LocalAuthentication.h>

@implementation NSObject (KLTouchFaceID)

/** 是否支持识别技术*/
+ (BOOL)kl_authSupport
{
    return [LAContext.alloc.init canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil];
}

+ (void)kl_authWithLocalizedReason:(NSString *)reason handle:(void (^)(BOOL success, NSError *error))handle
{
    LAContext *context = LAContext.alloc.init;
    NSError *error = nil;
    // 判断设备是否支持指纹、面容识别
    [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&error];
    if (error == nil) {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:reason reply:^(BOOL success, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (handle) {
                    handle(success, error);
                }
            });
        }];
    } else {
        if (handle) {
            handle(NO, error);
        }
    }
}

@end
