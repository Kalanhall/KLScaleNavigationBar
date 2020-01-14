//
//  UIButton+KLLayout.h
//  KLCategory
//
//  Created by Logic on 2019/11/25.
//

typedef NS_ENUM(NSUInteger, KLLayoutStyle){
    /** 正常位置，图左字右 */
    KLLayoutStyleImageLeft,
    /** 图右字左 */
    KLLayoutStyleImageRight,
    /** 图上字下 */
    KLLayoutStyleImageTop,
    /** 图下字上 */
    KLLayoutStyleImageBottom,
};

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (KLExtension)

/// 设置按钮内部图片及标题位置
///
/// @param Style 方向枚举
/// @param margin 图片和标题之间的间距
- (void)kl_layoutWithStyle:(KLLayoutStyle)Style margin:(CGFloat)margin;

/// 添加快捷事件
- (void)kl_controlEvents:(UIControlEvents)events completion:(void (^)(UIButton *sender))completion;

@end

NS_ASSUME_NONNULL_END

