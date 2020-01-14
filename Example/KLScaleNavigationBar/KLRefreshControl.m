//
//  KLRefreshControl.m
//  KLHomeService
//
//  Created by Logic on 2020/1/13.
//

#import "KLRefreshControl.h"
@import KLCategory;

#define KLRefreshHeight 60        // 控件触发刷新的高度

typedef NS_ENUM(NSInteger, KLRefreshState) {
    KLRefreshStateNormal = 0,     /** 普通状态 */
    KLRefreshStatePulling,        /** 释放刷新状态 */
    KLRefreshStateRefreshing,     /** 正在刷新 */
};

@interface KLRefreshControl ()

@property (strong, nonatomic) UIView  *backgroundView;
@property (assign, nonatomic) id refreshTarget;
@property (assign, nonatomic) SEL refreshAction;
@property (strong, nonatomic) UILabel *label;
@property (assign, nonatomic) KLRefreshState currentStatus;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (assign, nonatomic) CGFloat originY;

@end

@implementation KLRefreshControl

- (instancetype)initWithTargrt:(id)target refreshAction:(SEL)refreshAction
{
    self = [super initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, KLRefreshHeight)];
    if (self) {
        self.refreshTarget = target;
        self.refreshAction = refreshAction;
        
        self.backgroundView = [[UIView alloc] initWithFrame:self.frame];
        self.backgroundView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.backgroundView];
        
        self.label = UILabel.alloc.init;
        self.label.textColor = UIColor.whiteColor;
        self.label.font = [UIFont systemFontOfSize:11];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.text = NSLocalizedString(KLRefreshNormalTitle, nil);
        [self.backgroundView addSubview:self.label];
        self.label.frame = CGRectMake(0, self.frame.size.height - 20, UIScreen.mainScreen.bounds.size.width, 20);
    }
    return self;
}

- (void)dealloc
{
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

#pragma mark - KVO
- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        self.scrollView = (UIScrollView *)self.superview;
        self.originY = -self.scrollView.contentInset.top;
        [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    }
    
    // 移除系统菊花
    [self.subviews.firstObject removeFromSuperview];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
     if (self.scrollView.isDragging && !self.isRefreshing) {
        CGFloat offsetY =  -self.scrollView.contentInset.top - KLRefreshHeight;
        if (self.currentStatus == KLRefreshStatePulling && self.scrollView.contentOffset.y > offsetY) {
            self.currentStatus = KLRefreshStateNormal;
            self.label.text = KLRefreshNormalTitle;
        } else if (self.currentStatus == KLRefreshStateNormal && self.scrollView.contentOffset.y < offsetY) {
            self.currentStatus = KLRefreshStatePulling;
            self.label.text = KLRefreshPullingTitle;
        }
    } else if(!self.scrollView.isDragging) {
        if (self.currentStatus == KLRefreshStatePulling) {
            self.currentStatus = KLRefreshStateRefreshing;
            self.label.text = KLRefreshRefreshingTitle;
            [self beginRefreshing];
            [self performRefreshSelector];
        }
    }
    
    CGFloat pullDistance = -self.frame.origin.y;
    self.backgroundView.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, pullDistance);
    self.label.frame = CGRectMake(0, -self.frame.size.height * 1.1/3.0 + pullDistance, self.label.frame.size.width, self.label.frame.size.height);
}

#pragma mark - action

- (void)performRefreshSelector
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if (self.refreshTarget && [self.refreshTarget respondsToSelector:self.refreshAction])
        [self.refreshTarget performSelector:self.refreshAction];
#pragma clang diagnostic pop
    
}

- (void)beginRefreshing
{
    [super beginRefreshing];
}

- (void)endRefreshing
{
    self.currentStatus = KLRefreshStateNormal;
    self.label.text = KLRefreshNormalTitle;
    [super endRefreshing];
    [self.scrollView setContentOffset:CGPointMake(0, self.originY) animated:YES];
}

@end
