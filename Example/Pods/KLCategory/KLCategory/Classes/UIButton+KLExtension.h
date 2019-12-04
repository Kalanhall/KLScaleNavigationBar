//
//  UIButton+KLExtension.h
//  KLCategory
//
//  Created by Logic on 2019/11/25.
//

typedef NS_ENUM(NSUInteger, KLLayoutStatus){
    /** 正常位置，图左字右 */
    KLLayoutStatusNormal,
    /** 图右字左 */
    KLLayoutStatusImageRight,
    /** 图上字下 */
    KLLayoutStatusImageTop,
    /** 图下字上 */
    KLLayoutStatusImageBottom,
};

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (KLExtension)

/**
 * @brief 设置按钮内部图片及标题位置
 * @param status 方向枚举
 * @param margin 图片和标题之间的间距
 */
- (void)kl_layoutWithStatus:(KLLayoutStatus)status margin:(CGFloat)margin;

@end

NS_ASSUME_NONNULL_END

