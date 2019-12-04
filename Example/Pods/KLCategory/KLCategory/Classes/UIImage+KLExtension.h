//
//  UIImage+KLExtension.h
//  KLCategory
//
//  Created by Logic on 2019/11/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (KLExtension)

/**
 * @brief 生成一张1x1的矩形图片
 * @param color 颜色对象
 */
+ (instancetype)kl_imageWithColor:(UIColor *)color;

/**
 * @brief 生成一张指定尺寸的矩形图片
 * @param color 颜色对象
 * @param size  指定尺寸
 */
+ (instancetype)kl_imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 * @brief 优先使用自动释放缓存的方法
 * @param imageNamed  图片名
 * @discussion 获取非Asset中的图片需要写全名 image.png/image@2x.png
 */
+ (instancetype)kl_imageNamed:(NSString *)imageNamed;

/**
 * @brief 获取主工程中指定Bundle的图片
 * @param imageName  图片名
 * @param bundleName 指定Bundle名称
 */
+ (instancetype)kl_imageWithImageName:(NSString *)imageName bundleName:(NSString *)bundleName;

/**
 * @brief 获取第三方库中Bundle的图片
 * @param imageName  图片名
 * @param bundle 指定Bundle
 */
+ (instancetype)kl_imageWithImageName:(NSString *)imageName inBundle:(NSBundle *)bundle;

@end

NS_ASSUME_NONNULL_END
