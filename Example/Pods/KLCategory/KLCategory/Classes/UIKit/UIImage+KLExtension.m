//
//  UIImage+KLExtension.m
//  KLCategory
//
//  Created by Logic on 2019/11/25.
//

#import "UIImage+KLExtension.h"

@implementation UIImage (KLExtension)

+ (UIImage *)kl_imageWithColor:(UIColor *)color
{
    return [self kl_imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (instancetype)kl_imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect=CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (instancetype)kl_imageNamed:(NSString *)imageNamed
{
    NSString *path = [NSBundle.mainBundle pathForResource:imageNamed ofType:nil];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    if (image) return image;
    return [UIImage imageNamed:imageNamed];
}

+ (instancetype)kl_imageWithImageName:(NSString *)imageName bundleName:(NSString *)bundleName
{
    NSString *path = [NSBundle.mainBundle pathForResource:bundleName ofType:@"bundle"];
    NSBundle *imageBundle = [NSBundle bundleWithPath:path];
    UIImage *image = [UIImage imageNamed:imageName inBundle:imageBundle compatibleWithTraitCollection:nil];
    return image;
}

+ (instancetype)kl_imageWithImageName:(NSString *)imageName inBundle:(NSBundle *)bundle
{
    if (bundle == nil) return nil;
    NSURL *bundleURL = [bundle URLForResource:bundle.bundleIdentifier.pathExtension withExtension:@"bundle"];
    if (bundleURL == nil) return nil;
    NSBundle *imageBundle = [NSBundle bundleWithURL:bundleURL];
    UIImage *image = [UIImage imageNamed:imageName inBundle:imageBundle compatibleWithTraitCollection:nil];
    return image;
}

+ (instancetype)kl_imageWithImageName:(NSString *)imageName inBundleOfClass:(Class)classOfBundle
{
    return [self kl_imageWithImageName:imageName inBundle:[NSBundle bundleForClass:classOfBundle]];
}

- (instancetype)kl_imageWithCornerRadius:(CGFloat)radius
{
    return [self kl_imageWithCornerRadius:radius andSize:self.size];
}

- (instancetype)kl_imageWithCornerRadius:(CGFloat)radius andSize:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    CGContextAddPath(ctx,path.CGPath);
    CGContextClip(ctx);
    [self drawInRect:rect];
    CGContextDrawPath(ctx, kCGPathFillStroke);
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (instancetype)kl_compressWithMaxByte:(NSInteger)maxBtye
{
    CGFloat compress = 0.9f;
    NSData *data = UIImageJPEGRepresentation(self, compress);
    while (data.length > maxBtye && compress > 0.01) {
        compress -= 0.02f;
        data = UIImageJPEGRepresentation(self, compress);
    }
    return [UIImage imageWithData:data];
}

- (instancetype)kl_convertToGrayImage
{
    int width = self.size.width;
    int height = self.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(nil,width,height,8,0,colorSpace,kCGImageAlphaNone);
    CGColorSpaceRelease(colorSpace);
    if (context == NULL) {
        return nil;
    }
    CGContextDrawImage(context,CGRectMake(0, 0, width, height), self.CGImage);
    CGImageRef contextRef = CGBitmapContextCreateImage(context);
    UIImage *grayImage = [UIImage imageWithCGImage:contextRef];
    CGContextRelease(context);
    CGImageRelease(contextRef);
    return grayImage;
}

@end
