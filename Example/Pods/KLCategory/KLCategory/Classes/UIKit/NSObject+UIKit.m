//
//  NSObject+UIKit.m
//  KLCategory
//
//  Created by Logic on 2020/1/10.
//

#import "NSObject+UIKit.h"
#import "UIColor+KLExtension.h"
#import "UIImage+KLExtension.h"

@implementation NSObject (UIKit)

UIFont *KLAutoFont(CGFloat size) {
    return [UIFont systemFontOfSize:[NSObject kl_autoSize:size]];
}

UIFont *KLAutoBoldFont(CGFloat size) {
    return [UIFont boldSystemFontOfSize:[NSObject kl_autoSize:size]];
}

UIFont *KLAutoNameFont(NSString *name, CGFloat size) {
    return [UIFont fontWithName:name size:[NSObject kl_autoSize:size]];
}

UIColor *KLColor(unsigned int hexNumber) {
    return [UIColor kl_colorWithHexNumber:hexNumber];
}

UIColor *KLColorAlpha(unsigned int hexNumber, CGFloat alpha) {
    return [UIColor kl_colorWithHexNumber:hexNumber alpha:alpha];
}

UIImage *KLImageHex(unsigned int hexNumber) {
    return [UIImage kl_imageWithColor:KLColor(hexNumber)];
}

UIImage *KLImageColor(UIColor *color) {
    return [UIImage kl_imageWithColor:color];
}

UIImage *KLImageHexSize(unsigned int hexNumber, CGSize size) {
    return [UIImage kl_imageWithColor:KLColor(hexNumber) size:size];
}

UIImage *KLImageColorSize(UIColor *color, CGSize size) {
    return [UIImage kl_imageWithColor:color size:size];
}

UIViewController *KLCurrentController(void)
{ return [NSObject kl_findBestViewController:UIApplication.sharedApplication.keyWindow.rootViewController]; }

+ (UIViewController *)kl_findBestViewController:(UIViewController *)vc
{
    if (vc.presentedViewController) {
        return [self kl_findBestViewController:vc.presentedViewController];
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        UISplitViewController* svc = (UISplitViewController*)vc;
        if (svc.viewControllers.count > 0) {
            return [self kl_findBestViewController:svc.viewControllers.lastObject];
        } else {
            return vc;
        }
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController* svc = (UINavigationController*)vc;
        if (svc.viewControllers.count > 0) {
            return [self kl_findBestViewController:svc.topViewController];
        } else {
            return vc;
        }
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        UITabBarController* svc = (UITabBarController *)vc;
        if (svc.viewControllers.count > 0) {
            return [self kl_findBestViewController:svc.selectedViewController];
        } else {
            return vc;
        }
    } else {
        return vc;
    }
}

+ (CGFloat)kl_autoSize:(CGFloat)origin {
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return origin;
    }
    
    CGFloat base = 375.0;
    CGFloat width = MIN(UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height);
    
    CGFloat divisor = pow(10.0, MAX(0, 3));
    return round((origin * (width / base) * divisor)) / divisor;
}

@end
