//
//  UIImage+KLExtension.h
//  KLCategory
//
//  Created by Logic on 2019/11/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (KLExtension)

/// 生成一张1x1的矩形图片
///
/// @param color 颜色对象
///
/// @return 图片对象
+ (instancetype)kl_imageWithColor:(UIColor *)color;

/// 生成一张指定尺寸的矩形图片
///
/// @param color 颜色对象
/// @param size  指定尺寸
///
/// @return 图片对象
+ (instancetype)kl_imageWithColor:(UIColor *)color size:(CGSize)size;

/// 优先使用自动释放缓存的方法
///
/// @param imageNamed  图片名
/// @discussion 获取非Asset中的图片需要写全名 image.png/image@2x.png
///
/// @return 图片对象
+ (instancetype)kl_imageNamed:(NSString *)imageNamed;

 /// 获取主工程中指定Bundle的图片
///
 /// @param imageName  图片名
 /// @param bundleName 指定Bundle名称
///
 /// @return 图片对象
+ (instancetype)kl_imageWithImageName:(NSString *)imageName bundleName:(NSString *)bundleName;

/// 获取第三方库中Bundle的图片
///
/// @param imageName  图片名
/// @param bundle 指定Bundle
///
/// @return 图片对象
+ (instancetype)kl_imageWithImageName:(NSString *)imageName inBundle:(NSBundle *)bundle;

/// 获取第三方库中Bundle的图片
///
/// @param imageName  图片名
/// @param classOfBundle 指定Bundle中的类
///
/// @return 图片对象
+ (instancetype)kl_imageWithImageName:(NSString *)imageName inBundleOfClass:(Class)classOfBundle;

/// 生成原图大小一致的圆角图片
///
/// @param radius 圆角值
///
/// @return 图片对象
- (instancetype)kl_imageWithCornerRadius:(CGFloat)radius;

/// 生成指定大小的圆角图片
///
/// @param radius 圆角值
/// @param size 指定大小
///
/// @return 图片对象
- (instancetype)kl_imageWithCornerRadius:(CGFloat)radius andSize:(CGSize)size;

/// 图片压缩
///
/// @param maxBtye 允许压缩的最大值，但实际上最小只能压缩为原来的1/10
///
/// @return 图片对象
- (instancetype)kl_compressWithMaxByte:(NSInteger)maxBtye;

/// 获取一张灰度图
- (instancetype)kl_convertToGrayImage;

@end

NS_ASSUME_NONNULL_END
