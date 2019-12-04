//
//  NSObject+KLExtension.m
//  KLCategory
//
//  Created by Logic on 2019/11/30.
//

#import "NSObject+KLExtension.h"

@implementation NSObject (KLExtension)

CGFloat ScreenWidth(void) {
    return UIScreen.mainScreen.bounds.size.width;
}

CGFloat ScreenHeight(void) {
    return UIScreen.mainScreen.bounds.size.height;
}

CGFloat Auto(CGFloat origin) {
    
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return origin;
    }
    
    CGFloat base = 375.0;
    CGFloat width = MIN(ScreenWidth(), ScreenHeight());
    
    CGFloat divisor = pow(10.0, MAX(0, 3));
    return round((origin * (width / base) * divisor)) / divisor;
}

CGFloat Auto_Status(void) {
    return UIApplication.sharedApplication.statusBarFrame.size.height;
}

CGFloat Auto_Top(void) {
    return UIApplication.sharedApplication.statusBarFrame.size.height + 44.0;
}

CGFloat Auto_BottomInset(void) {
    CGFloat botomInset = 0;
    if (@available(iOS 11.0, *)) {
        UIWindow *window = UIApplication.sharedApplication.delegate.window;
        botomInset = window.safeAreaInsets.bottom;
    }
    return botomInset;
}

CGFloat Auto_Bottom(void) {
    return Auto_BottomInset() + 49.0;
}

BOOL isPhone(void) {
    return UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPhone;
}

BOOL isPhoneX(void) {
    return Auto_BottomInset() > 0;
}

@end
