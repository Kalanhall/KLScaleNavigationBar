//
//  KLScaleNavigationBar.m
//  KLScaleNavigationBar
//
//  Created by Logic on 2019/12/4.
//

@import Masonry;
#import "KLScaleNavigationBar.h"

#define ScaleSize(temp)  (MIN(UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height) / 375.0 * temp)

@interface KLScaleNavigationBar () <UITextFieldDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *backgroundView;
@property (strong, nonatomic) UIImageView *searchBackgroundView;
@property (strong, nonatomic) UIImageView *bannerBackgroundView;
@property (strong, nonatomic) UIImageView *activityView;
@property (strong, nonatomic) UITextField *searchBar;
@property (strong, nonatomic) UIImageView *searchBarLeftView;
@property (strong, nonatomic) UIImageView *searchBarRightView;
@property (assign, nonatomic) CGFloat contenTopInset;

@end

@implementation KLScaleNavigationBar

- (instancetype)initWithFrame:(CGRect)frame scrollView:(UIScrollView *)scrollView
{
    // 前置设置
    if (CGRectEqualToRect(frame, CGRectZero)) {
        frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, (UIApplication.sharedApplication.statusBarFrame.size.height + 44.0) + 41);
    } else if (frame.size.height < (UIApplication.sharedApplication.statusBarFrame.size.height + 44.0) + 41) {
        frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, (UIApplication.sharedApplication.statusBarFrame.size.height + 44.0) + 41);
    }
    
    scrollView.contentInset = UIEdgeInsetsMake(frame.size.height,
                                               self.scrollView.contentInset.left,
                                               self.scrollView.contentInset.bottom,
                                               self.scrollView.contentInset.right);
    [scrollView setContentOffset:CGPointMake(0, -frame.size.height)];
    
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollView = scrollView;
        self.contenTopInset = scrollView.contentInset.top;
        NSAssert(scrollView.superview != nil, @"scrollView 必须先添加到self.view上");
        
        self.backgroundView = UIImageView.alloc.init;
        self.backgroundView.contentMode = UIViewContentModeScaleAspectFill;
        self.backgroundView.clipsToBounds = YES;
        self.backgroundView.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
        [self.scrollView.superview addSubview:self.backgroundView];
        [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(UIApplication.sharedApplication.statusBarFrame.size.height + 44.0);
        }];
        
        self.searchBackgroundView = UIImageView.alloc.init;
        self.searchBackgroundView.contentMode = UIViewContentModeScaleAspectFill;
        self.searchBackgroundView.clipsToBounds = YES;
        self.searchBackgroundView.backgroundColor = self.backgroundView.backgroundColor;
        [self.scrollView.superview insertSubview:self.searchBackgroundView belowSubview:self.backgroundView];
        [self.searchBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.backgroundView.mas_bottom);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(41);
        }];
        
        _bannerHeight = ScaleSize(140);
        self.bannerBackgroundView = UIImageView.alloc.init;
        self.bannerBackgroundView.contentMode = UIViewContentModeScaleAspectFill;
        self.bannerBackgroundView.clipsToBounds = YES;
        self.bannerBackgroundView.backgroundColor = self.backgroundView.backgroundColor;
        [self.scrollView.superview insertSubview:self.bannerBackgroundView belowSubview:self.scrollView];
        [self.bannerBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.searchBackgroundView.mas_bottom);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(_bannerHeight);
        }];
        
        self.searchBar = UITextField.alloc.init;
        self.searchBar.backgroundColor = UIColor.whiteColor;
        self.searchBar.layer.cornerRadius = 15;
        self.searchBar.layer.masksToBounds = YES;
        self.searchBar.font = [UIFont boldSystemFontOfSize:13];
        self.searchBar.text = @"搜索";
        self.searchBar.textColor = [UIColor colorWithRed:0.608 green:0.608 blue:0.608 alpha:1];
        self.searchBar.delegate = self;
        [self addSubview:self.searchBar];
        [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(30);
            make.bottom.mas_equalTo(-10);
        }];
        
        UIView *lcontent = UIView.alloc.init;
        lcontent.frame = CGRectMake(0, 0, 40, 30);
        UIImageView *lsearch = UIImageView.alloc.init;
        lsearch.contentMode = UIViewContentModeCenter;
        lsearch.frame = lcontent.frame;
        [lcontent addSubview:lsearch];
        self.searchBarLeftView = lsearch;
        self.searchBar.leftView = lcontent;
        self.searchBar.leftViewMode = UITextFieldViewModeAlways;
        
        UIView *rcontent = UIView.alloc.init;
        rcontent.frame = CGRectMake(0, 0, 45, 30);
        UIImageView *rsearch = UIImageView.alloc.init;
        rsearch.contentMode = UIViewContentModeCenter;
        rsearch.frame = lcontent.frame;
        [rcontent addSubview:rsearch];
        self.searchBarRightView = rsearch;
        self.searchBar.rightView = rcontent;
        self.searchBar.rightViewMode = UITextFieldViewModeAlways;
        
        self.activityView = UIImageView.alloc.init;
        self.activityView.clipsToBounds = YES;
        self.activityView.contentMode = UIViewContentModeScaleToFill;
        [self.scrollView.superview insertSubview:self.activityView belowSubview:self.scrollView];
        self.activityView.alpha = 0;
        self.activityBottomFixHeight = 90;
    }
    return self;
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    [self.activityView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.mas_bottom).offset(self.activityBottomFixHeight);
    }];
}

- (void)setBannerHeight:(CGFloat)bannerHeight
{
    _bannerHeight = bannerHeight;
    [self.bannerBackgroundView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(bannerHeight);
    }];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (self.searchBarDidBeginEditing) {
        self.searchBarDidBeginEditing();
    }
    return NO;
}

- (void)scaleBarWithRightSpace:(CGFloat)space refreshHeight:(CGFloat)height {
    CGFloat position = self.scrollView.contentOffset.y;
    height = height > 0 ? height : 60.0;
    
    // 背景图临界值处理
    if (position <= -self.contenTopInset) {
        // 下拉
        CGFloat alpha = fabs(position + self.contenTopInset) / (height * 0.5);
        self.alpha = 1 - alpha;
        self.activityView.alpha = alpha;
        self.backgroundView.alpha = 1 - alpha;
        self.searchBackgroundView.alpha = 1 - alpha;
        self.backgroundView.transform = CGAffineTransformMakeTranslation(0, - position - self.contenTopInset);
        if (fabs(position + self.contenTopInset) >= height) {
            self.activityView.transform = CGAffineTransformMakeTranslation(0, - position - self.contenTopInset - height);
        } else {
            self.activityView.transform = CGAffineTransformIdentity;
        }
    } else {
        // 上拉
        self.alpha = 1;
        self.activityView.alpha = 0;
        self.backgroundView.alpha = 1;
        self.searchBackgroundView.alpha = 1;
        self.backgroundView.transform = CGAffineTransformIdentity;
        self.activityView.transform = CGAffineTransformMakeTranslation(0, - position - self.contenTopInset);
    }
    self.searchBackgroundView.transform = CGAffineTransformMakeTranslation(0, - position - self.contenTopInset);
    self.bannerBackgroundView.transform = CGAffineTransformMakeTranslation(0, - position - self.contenTopInset);
    
    // 导航栏临界值处理
    if (position < -self.contenTopInset) {
        position = -self.contenTopInset;
    } else if (position > -(UIApplication.sharedApplication.statusBarFrame.size.height + 44.0)) {
        position = -(UIApplication.sharedApplication.statusBarFrame.size.height + 44.0);
    }
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, fabs(position));
    
    // 导航栏实时移动距离
    CGFloat move = self.contenTopInset + position;
    // 搜索栏位移
    CGFloat real = self.contenTopInset - (UIApplication.sharedApplication.statusBarFrame.size.height + 44.0);    // 实际经过距离
    CGFloat target = space;                             // 右侧预留距离
    CGFloat update = move / real * target * 2/*加速到达终点的倍数*/; // 右边间距实时距离
    if (update >= target) {
        update = target;
    }
    [self.searchBar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10 - update); // 右边距离从 10 -> target 变化
        make.bottom.mas_equalTo(-10 + move / real * 3); // 底部距离从 10 -> 7变化
    }];
    
    // 左视图透明度处理
    CGFloat alpha = 1 - (position + self.contenTopInset) / real;
    self.leftView.alpha = alpha;
    for (UIView *item in self.leftViews) {
        item.alpha = alpha;
    }
}

- (void)setLeftView:(UIView *)leftView {
    _leftView = leftView;
    [self insertSubview:leftView belowSubview:self.searchBar];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(UIApplication.sharedApplication.statusBarFrame.size.height);
        make.right.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(44.0);
    }];
}

- (void)setRightView:(UIView *)rightView {
    _rightView = rightView;
    [self addSubview:rightView];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(UIApplication.sharedApplication.statusBarFrame.size.height);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(44.0);
    }];
}

- (void)setLeftViews:(NSArray<UIView *> *)leftViews {
    _leftViews = leftViews;
    [leftViews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.tag = idx;
        [self insertSubview:obj belowSubview:self.searchBar];
        if (idx == 0) {
            [obj mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(-10);
                make.top.mas_equalTo(UIApplication.sharedApplication.statusBarFrame.size.height);
                make.width.mas_equalTo(35);
                make.height.mas_equalTo(44.0);
            }];
        } else {
            UIView *view = leftViews[idx - 1];
            [obj mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(view.mas_right);
                make.centerY.width.height.mas_equalTo(view);
            }];
        }
    }];
}

- (void)setRightViews:(NSArray<UIView *> *)rightViews {
    _rightViews = rightViews;
    [rightViews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.tag = idx;
        [self addSubview:obj];
        if (idx == 0) {
            [obj mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-5);
                make.top.mas_equalTo(UIApplication.sharedApplication.statusBarFrame.size.height);
                make.width.mas_equalTo(35);
                make.height.mas_equalTo(44.0);
            }];
        } else {
            UIView *view = rightViews[idx - 1];
            [obj mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(view.mas_left);
                make.centerY.width.height.mas_equalTo(view);
            }];
        }
    }];
}

@end
