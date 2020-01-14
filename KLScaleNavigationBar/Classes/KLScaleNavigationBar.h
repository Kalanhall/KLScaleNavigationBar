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
/// 搜索栏背景图
@property (strong, nonatomic, readonly) UIImageView *searchBackgroundView;
/// 轮播图背景图
@property (strong, nonatomic, readonly) UIImageView *bannerBackgroundView;
/// 根据实际轮播图高度设置，默认auto(140)
@property (assign, nonatomic) CGFloat bannerHeight;
/// 活动广告图，固定距离导航栏底部距离，默认90
@property (assign, nonatomic) CGFloat activityBottomFixHeight;
/// 导航栏背景图底部活动预告图，层级位于scrollView的superView上
@property (strong, nonatomic, readonly) UIImageView *activityView;
/// 搜索栏
@property (strong, nonatomic, readonly) UITextField *searchBar;
/// 搜索框左视图
@property (strong, nonatomic, readonly) UIImageView *searchBarLeftView;
/// 搜索框右视图
@property (strong, nonatomic, readonly) UIImageView *searchBarRightView;
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
