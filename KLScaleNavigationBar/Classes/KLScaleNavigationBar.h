//
//  KLScaleNavigationBar.h
//  KLScaleNavigationBar
//
//  Created by Logic on 2019/12/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLScaleNavigationBar : UIView

/// 被监听的滚动视图
@property (strong, nonatomic, readonly) UIScrollView *scrollView;
/// 导航栏背景图
@property (strong, nonatomic, readonly) UIImageView *backgroundView;
/// 导航栏背景图底部占位图，图片与backgroundView一致，层级位于scrollView的superView上
@property (strong, nonatomic, readonly) UIImageView *botView;
/// 导航栏背景图底部活动预告图，层级位于scrollView的superView上
@property (strong, nonatomic, readonly) UIImageView *topView;
/// 搜索栏
@property (strong, nonatomic, readonly) UITextField *searchBar;
/// 搜索图标
@property (strong, nonatomic) UIImage *searchImage;
/// 单个左视图，其约束宽度为屏宽一半
@property (strong, nonatomic) UIView *leftView;
/// 右视图
@property (strong, nonatomic) UIView *rightView;
/// 用法参考NavigationItem
@property (strong, nonatomic) NSArray <UIView *> *leftViews;
/// 用法参考NavigationItem
@property (strong, nonatomic) NSArray <UIView *> *rightViews;

/// 点击搜索栏回调
@property (strong, nonatomic) void (^searchBarDidBeginEditing)(void);

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

/// 构造方法，创建一个和屏幕宽度一样，拥有最小高度的实例
///
/// @Param scrollView 需要监听位移的滚动视图
///
/// @Return KLDynamicNavigationBar 实例
///
- (instancetype)initWithScrollView:(UIScrollView *)scrollView;

/// 构造方法
///
/// @Param frame bar尺寸，有高度限制，最小高度 = 导航栏高度 + 37（搜索栏高度30 + 间距7）
/// @Param scrollView 需要监听位移的滚动视图
///
/// @Return KLDynamicNavigationBar 实例
///
- (instancetype)initWithFrame:(CGRect)frame scrollView:(UIScrollView *)scrollView;

/// 监听滚动视图移动，改变内部视图显示
///
/// scrollViewDidScroll 代理中调用
///
/// @Param space bar预留给右视图的位置
/// @Param height 刷新控件高度
///
- (void)scaleBarWithRightSpace:(CGFloat)space refreshHeight:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
