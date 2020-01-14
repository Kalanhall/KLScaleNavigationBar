//
//  NSObject+UIKit.h
//  KLCategory
//
//  Created by Logic on 2020/1/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (UIKit)

/// 自适配字体
extern UIFont *KLAutoFont(CGFloat size);
/// 自适配粗体字体
extern UIFont *KLAutoBoldFont(CGFloat size);
/// 自适配粗体字体
/// @param name 字体名称
/// @param size 字体大小
extern UIFont *KLAutoNameFont(NSString *name, CGFloat size);

/// 16进制颜色
extern UIColor *KLColor(unsigned int hexNumber);
/// 16进制透明通道颜色
extern UIColor *KLColorAlpha(unsigned int hexNumber, CGFloat alpha);

/// 纯色图片 size = {1,1}
extern UIImage *KLImageHex(unsigned int hexNumber);
/// 纯色图片 size = {1,1}
extern UIImage *KLImageColor(UIColor *color);
/// 指定尺寸纯色图片
extern UIImage *KLImageHexSize(unsigned int hexNumber, CGSize size);
/// 指定尺寸纯色图片
extern UIImage *KLImageColorSize(UIColor *color, CGSize size);

/// 获取应用当前控制器
///
/// 注意：需要等到控制器viewDidAppear之后才能获取到正确的控制器
/// 使用：KLCurrentController()
/// @return 应用顶层控制器实例
extern UIViewController *KLCurrentController(void);

@end

NS_ASSUME_NONNULL_END
