//
//  UIView+KLFrame.h
//  KLCategory
//
//  Created by Logic on 2019/12/2.
//

#import <UIKit/UIKit.h>

@interface UIView (KLExtension)

// MARK: - 尺寸相关
@property (assign, nonatomic) IBInspectable CGFloat kl_x;
@property (assign, nonatomic) IBInspectable CGFloat kl_y;
@property (assign, nonatomic) IBInspectable CGFloat kl_width;
@property (assign, nonatomic) IBInspectable CGFloat kl_height;
@property (assign, nonatomic) IBInspectable CGSize  kl_size;
@property (assign, nonatomic) IBInspectable CGFloat kl_centerX;
@property (assign, nonatomic) IBInspectable CGFloat kl_centerY;

// MARK: - 圆角/阴影相关
/// layer圆角
@property (assign, nonatomic) IBInspectable CGFloat kl_cornerRadius;
/// 截边的layer圆角
@property (assign, nonatomic) IBInspectable CGFloat kl_cornerRadiusByClips;
/// 默认阴影，生成一个透明度0.2 / 位移 {0, 0} 阴影
@property (strong, nonatomic) IBInspectable UIColor *kl_shadowColor;
/// 调整阴影透明度
@property (assign, nonatomic) IBInspectable CGFloat kl_shadowOpacity;
/// 调整阴影位移
@property (assign, nonatomic) IBInspectable CGSize kl_shadowOffset;

// MARK: - 角标相关
/// 角标
@property (strong, nonatomic) UILabel *kl_badge;
/// 角标的值
@property (strong, nonatomic) IBInspectable NSString *kl_badgeValue;
/// 角标背景颜色
@property (strong, nonatomic) IBInspectable UIColor *kl_badgeBGColor;
/// 角标文字颜色
@property (strong, nonatomic) IBInspectable UIColor *kl_badgeTextColor;
/// 角标文字的字体
@property (strong, nonatomic) IBInspectable UIFont *kl_badgeFont;
/// 角标边距
@property (assign, nonatomic) IBInspectable CGFloat kl_badgePadding;
/// 角标最小的大小
@property (assign, nonatomic) IBInspectable CGFloat kl_badgeMinSize;
/// 角标x坐标
@property (assign, nonatomic) IBInspectable CGFloat kl_badgeX;
/// 角标y坐标
@property (assign, nonatomic) IBInspectable CGFloat kl_badgeY;
/// 如果是数字0的话就隐藏角标不显示
@property (assign, nonatomic) IBInspectable BOOL kl_shouldHideBadgeAtZero;
/// 显示角标是否要缩放动画
@property (assign, nonatomic) IBInspectable BOOL kl_shouldAnimateBadge;

// MARK: - 快捷事件注册
/// 添加手势
- (void)kl_setTapCompletion:(void (^)(UITapGestureRecognizer *tapGesture))completion;
/// 添加长按手势
- (void)kl_setLongPressCompletion:(void (^)(UILongPressGestureRecognizer *tapGesture))completion;

// MARK: - 快捷遍历
/// 当前视图所在控制器
- (UIViewController *)kl_controller;
/// 获取本视图中指定类子视图
- (instancetype)kl_subviewOfClass:(Class)cls;
/// 获取本视图中指定类子视图集合
- (NSArray <UIView *> *)kl_subviewsOfClass:(Class)cls;

@end
