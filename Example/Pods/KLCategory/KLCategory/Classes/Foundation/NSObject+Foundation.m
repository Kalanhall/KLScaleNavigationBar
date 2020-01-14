//
//  NSObject+KLExtension.m
//  KLCategory
//
//  Created by Logic on 2019/11/30.
//

#import "NSObject+Foundation.h"

@implementation NSObject (Foundation)

// MARK: - Foundation
BOOL KLIsphone(void) {
    return UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPhone;
}

BOOL KLIsphoneXabove(void) {
    return KLIsphone() && KLAutoBottomInset() > 0;
}

CGFloat KLScreenWidth(void) {
    return UIScreen.mainScreen.bounds.size.width;
}

CGFloat KLScreenHeight(void) {
    return UIScreen.mainScreen.bounds.size.height;
}

CGFloat KLAuto(CGFloat origin) {
    
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return origin;
    }
    
    CGFloat base = 375.0;
    CGFloat width = MIN(KLScreenWidth(), KLScreenHeight());
    
    CGFloat divisor = pow(10.0, MAX(0, 3));
    return round((origin * (width / base) * divisor)) / divisor;
}

CGFloat KLAutoStatus(void) {
    return UIApplication.sharedApplication.statusBarFrame.size.height;
}

CGFloat KLAutoTop(void) {
    return UIApplication.sharedApplication.statusBarFrame.size.height + 44.0;
}

CGFloat KLAutoBottomInset(void) {
    CGFloat botomInset = 0;
    if (@available(iOS 11.0, *)) {
        UIWindow *window = UIApplication.sharedApplication.delegate.window;
        botomInset = window.safeAreaInsets.bottom;
    }
    return botomInset;
}

CGFloat KLAutoBottom(void) {
    return KLAutoBottomInset() + 49.0;
}

// MARK: - Math
CGFloat KLDegreesToRadian(CGFloat degrees) {
    return (M_PI * (degrees) / 180.0);
}

CGFloat KLRadianToDegrees(CGFloat radian) {
    return (radian * 180.0) / (M_PI);
}

CGFloat KLSumOfArray(NSArray *numbers) {
    CGFloat sum = 0;
    sum = [[numbers valueForKeyPath:@"@sum.floatValue"] floatValue];
    return sum;
}

CGFloat KLAverageOfArray(NSArray *numbers) {
    CGFloat avg = 0;
    avg = [[numbers valueForKeyPath:@"@avg.floatValue"] floatValue];
    return avg;
}

CGFloat KLMaxNumberOfArray(NSArray *numbers) {
    CGFloat max = 0;
    max = [[numbers valueForKeyPath:@"@max.floatValue"] floatValue];
    return max;
}

CGFloat KLMinNumberOfArray(NSArray *numbers) {
    CGFloat min = 0;
    min = [[numbers valueForKeyPath:@"@min.floatValue"] floatValue];
    return min;
}

@end
