//
//  UIImage+KLExtension.m
//  KLCategory
//
//  Created by Logic on 2019/11/25.
//

#import "UIImage+KLExtension.h"

@implementation UIImage (KLExtension)

+ (UIImage *)kl_imageWithColor:(UIColor *)color {
    return [self kl_imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (instancetype)kl_imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect=CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (instancetype)kl_imageNamed:(NSString *)imageNamed {
    NSString *path = [NSBundle.mainBundle pathForResource:imageNamed ofType:nil];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    if (image) return image;
    return [UIImage imageNamed:imageNamed];
}

+ (instancetype)kl_imageWithImageName:(NSString *)imageName bundleName:(NSString *)bundleName {
    NSString *path = [NSBundle.mainBundle pathForResource:bundleName ofType:@"bundle"];
    NSBundle *imageBundle = [NSBundle bundleWithPath:path];
    UIImage *image = [UIImage imageNamed:imageName inBundle:imageBundle compatibleWithTraitCollection:nil];
    return image;
}

+ (instancetype)kl_imageWithImageName:(NSString *)imageName inBundle:(NSBundle *)bundle {
    if (bundle == nil) return nil;
    NSURL *bundleURL = [bundle URLForResource:bundle.bundleIdentifier.pathExtension withExtension:@"bundle"];
    if (bundleURL == nil) return nil;
    NSBundle *imageBundle = [NSBundle bundleWithURL:bundleURL];
    UIImage *image = [UIImage imageNamed:imageName inBundle:imageBundle compatibleWithTraitCollection:nil];
    return image;
}

@end
