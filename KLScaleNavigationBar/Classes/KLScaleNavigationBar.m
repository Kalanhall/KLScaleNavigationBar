//
//  KLScaleNavigationBar.m
//  KLScaleNavigationBar
//
//  Created by Logic on 2019/12/4.
//

@import Masonry;
#import "KLScaleNavigationBar.h"

@interface KLScaleNavigationBar () <UITextFieldDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *backgroundView;
@property (strong, nonatomic) UIImageView *botView;
@property (strong, nonatomic) UIImageView *topView;
@property (strong, nonatomic) UITextField *searchBar;
@property (strong, nonatomic) UIImageView *searchBarLeftView;
@property (assign, nonatomic) CGFloat contenTopInset;

@end

@implementation KLScaleNavigationBar

- (instancetype)initWithScrollView:(UIScrollView *)scrollView
{
    return [self initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, (UIApplication.sharedApplication.statusBarFrame.size.height + 44.0) + 37) scrollView:scrollView];
}

- (instancetype)initWithFrame:(CGRect)frame scrollView:(UIScrollView *)scrollView
{
    // 高度限制
    if (CGRectEqualToRect(frame, CGRectZero)) {
        frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, (UIApplication.sharedApplication.statusBarFrame.size.height + 44.0) + 37);
    } else if (frame.size.height < (UIApplication.sharedApplication.statusBarFrame.size.height + 44.0) + 37) {
        frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, (UIApplication.sharedApplication.statusBarFrame.size.height + 44.0) + 37);
    }
    
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollView = scrollView;
        self.scrollView.backgroundColor = UIColor.clearColor;
        self.scrollView.contentInset = UIEdgeInsetsMake(frame.size.height,
                                                        self.scrollView.contentInset.left,
                                                        self.scrollView.contentInset.bottom,
                                                        self.scrollView.contentInset.right);
        self.contenTopInset = scrollView.contentInset.top;
        NSAssert(scrollView.superview != nil, @"scrollView 必须先添加到self.view上");
        
        self.backgroundView = UIImageView.alloc.init;
        self.backgroundView.contentMode = UIViewContentModeTop;
        self.backgroundView.clipsToBounds = YES;
        [self addSubview:self.backgroundView];
        [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
        self.searchBar = UITextField.alloc.init;
        self.searchBar.backgroundColor = UIColor.whiteColor;
        self.searchBar.layer.cornerRadius = 15;
        self.searchBar.layer.masksToBounds = YES;
        self.searchBar.font = [UIFont boldSystemFontOfSize:13];
        self.searchBar.text = @"搜索";
        self.searchBar.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
        self.searchBar.delegate = self;
        [self addSubview:self.searchBar];
        [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(30);
            make.bottom.mas_equalTo(-7);
        }];
        
        UIView *lcontent = UIView.alloc.init;
        lcontent.frame = CGRectMake(0, 0, 40, 30);
        UIImageView *search = UIImageView.alloc.init;
        search.contentMode = UIViewContentModeCenter;
        search.frame = lcontent.frame;
        [lcontent addSubview:search];
        self.searchBarLeftView = search;
        self.searchBar.leftView = lcontent;
        self.searchBar.leftViewMode = UITextFieldViewModeAlways;
        
        self.botView = UIImageView.alloc.init;
        self.botView.clipsToBounds = YES;
        self.botView.contentMode = UIViewContentModeTop;
        [self.scrollView.superview insertSubview:self.botView belowSubview:self.scrollView];
        [self.botView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(frame.size.height * 1.8);
        }];
        
        self.topView = UIImageView.alloc.init;
        self.topView.clipsToBounds = YES;
        self.topView.contentMode = UIViewContentModeScaleAspectFill;
        [self.scrollView.superview insertSubview:self.topView belowSubview:self.scrollView];
        [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(self.botView);
            make.height.mas_equalTo(self.scrollView.superview);
        }];
        self.topView.alpha = 0;
    }
    return self;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (self.searchBarDidBeginEditing) {
        self.searchBarDidBeginEditing();
    }
    return NO;
}

- (void)scaleBarWithRightSpace:(CGFloat)space refreshHeight:(CGFloat)height {
    CGFloat position = self.scrollView.contentOffset.y;
    
    // 背景图临界值处理
    if (position < -self.contenTopInset) {
        // 下拉透明度处理 & 占位图/广告图 位移处理
        CGFloat alpha = fabs(position + self.contenTopInset) / height;
        self.alpha = 1 - alpha;
        self.backgroundView.alpha = 0;
        self.topView.alpha = alpha;
        if (fabs(position + self.contenTopInset) >= height) {
            self.topView.transform = CGAffineTransformMakeTranslation(0, - position - self.contenTopInset - height);
        }
        self.botView.transform = CGAffineTransformIdentity;
    } else {
        // 上拉透明度处理 & 占位图/广告图 位移处理
        self.alpha = 1;
        self.backgroundView.alpha = 1;
        self.topView.alpha = 0;
        self.topView.transform = CGAffineTransformIdentity;
        self.botView.transform = CGAffineTransformMakeTranslation(0, - position - self.contenTopInset);
    }
    
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
        make.right.mas_equalTo(-10 - update);
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
    [self addSubview:leftView];
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
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(44.0);
    }];
}

- (void)setLeftViews:(NSArray<UIView *> *)leftViews {
    _leftViews = leftViews;
    [leftViews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.tag = idx;
        [self addSubview:obj];
        if (idx == 0) {
            [obj mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(-10);
                make.top.mas_equalTo(UIApplication.sharedApplication.statusBarFrame.size.height);
                make.width.mas_equalTo(40);
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
                make.right.mas_equalTo(-10);
                make.top.mas_equalTo(UIApplication.sharedApplication.statusBarFrame.size.height);
                make.width.mas_equalTo(40);
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

- (void)setSearchImage:(UIImage *)searchImage {
    _searchImage = searchImage;
    self.searchBarLeftView.image = searchImage;
}

@end
