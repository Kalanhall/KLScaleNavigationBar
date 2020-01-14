//
//  UIView+KLFrame.m
//  KLCategory
//
//  Created by Logic on 2019/12/2.
//

#import "UIView+KLExtension.h"
#import <objc/runtime.h>

@implementation UIView (KLExtension)

@dynamic kl_badgeValue, kl_badgeBGColor, kl_badgeTextColor, kl_badgeFont;
@dynamic kl_badgePadding, kl_badgeMinSize, kl_badgeX, kl_badgeY;
@dynamic kl_shouldHideBadgeAtZero, kl_shouldAnimateBadge;

// MARK: - 尺寸相关
- (void)setKl_x:(CGFloat)kl_x
{
    self.frame = CGRectMake(kl_x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)kl_x
{
    return self.frame.origin.x;
}

- (void)setKl_y:(CGFloat)kl_y
{
    self.frame = CGRectMake(self.frame.origin.x, kl_y, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)kl_y
{
    return self.frame.origin.y;
}

- (void)setKl_width:(CGFloat)kl_width
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, kl_width, self.frame.size.height);
}

- (CGFloat)kl_width
{
    return self.frame.size.width;
}

- (void)setKl_height:(CGFloat)kl_height
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, kl_height);
}

- (CGFloat)kl_height
{
    return self.frame.size.height;
}

- (void)setKl_size:(CGSize)kl_size
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, kl_size.width, kl_size.height);
}

- (CGSize)kl_size
{
    return self.frame.size;
}

- (void)setKl_centerX:(CGFloat)kl_centerX
{
    self.center = CGPointMake(kl_centerX, self.center.y);
}

- (CGFloat)kl_centerX
{
    return self.center.x;
}

- (void)setKl_centerY:(CGFloat)kl_centerY
{
    self.center = CGPointMake(self.center.x, kl_centerY);
}

- (CGFloat)kl_centerY
{
    return self.center.y;
}

// MARK: - 圆角/阴影相关
- (void)setKl_cornerRadius:(CGFloat)kl_cornerRadius
{
    self.layer.cornerRadius = kl_cornerRadius;
}

- (CGFloat)kl_cornerRadius
{
    return self.layer.cornerRadius;
}

- (void)setKl_cornerRadiusByClips:(CGFloat)kl_cornerRadiusByClips
{
    self.layer.cornerRadius = kl_cornerRadiusByClips;
    self.layer.masksToBounds = YES;
}

- (CGFloat)kl_cornerRadiusByClips
{
    return self.layer.cornerRadius;
}

- (void)setKl_shadowColor:(UIColor *)kl_shadowColor
{
    self.layer.shadowColor = kl_shadowColor.CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowOpacity = 0.2;
    if (self.layer.cornerRadius > 0) {
        self.layer.shadowRadius = self.layer.cornerRadius;
    }
}

- (UIColor *)kl_shadowColor
{
    return [UIColor colorWithCGColor:self.layer.shadowColor];
}

- (void)setKl_shadowOpacity:(CGFloat)kl_shadowOpacity
{
    self.layer.shadowOpacity = kl_shadowOpacity;
}

- (CGFloat)kl_shadowOpacity
{
    return self.layer.shadowOpacity;
}

- (void)setKl_shadowOffset:(CGSize)kl_shadowOffset
{
    self.layer.shadowOffset = kl_shadowOffset;
}

- (CGSize)kl_shadowOffset
{
    return self.layer.shadowOffset;
}

// MARK: - 角标相关
- (void)kl_badgeInit
{
    self.kl_badgeBGColor   = [UIColor redColor];
    self.kl_badgeTextColor = [UIColor whiteColor];
    self.kl_badgeFont      = [UIFont systemFontOfSize:10.0];
    self.kl_badgePadding   = 5;
    self.kl_badgeMinSize   = 4;
    self.kl_badgeX   = self.frame.size.width - self.kl_badge.frame.size.width * 0.5 - 3;
    self.kl_badgeY   = -6;
    self.kl_shouldHideBadgeAtZero = YES;
    self.kl_shouldAnimateBadge = YES;
    self.clipsToBounds = NO;
}

- (void)kl_refreshBadge
{
    self.kl_badge.textColor        = self.kl_badgeTextColor;
    self.kl_badge.backgroundColor  = self.kl_badgeBGColor;
    self.kl_badge.font             = self.kl_badgeFont;
}

- (CGSize)kl_badgeExpectedSize
{
    UILabel *frameLabel = [self kl_duplicateLabel:self.kl_badge];
    [frameLabel sizeToFit];
    
    CGSize expectedLabelSize = frameLabel.frame.size;
    return expectedLabelSize;
}

- (void)kl_updateBadgeValueAnimated:(BOOL)animated
{
    if ((!self.kl_badgeValue || [self.kl_badgeValue isEqualToString:@""] || [self.kl_badgeValue isEqualToString:@"0"]) && self.kl_shouldHideBadgeAtZero) {
        [self kl_removeBadge];
        return;
    }
    
    if (animated && self.kl_shouldAnimateBadge && ![self.kl_badge.text isEqualToString:self.kl_badgeValue]) {
        CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        [animation setFromValue:[NSNumber numberWithFloat:1.5]];
        [animation setToValue:[NSNumber numberWithFloat:1]];
        [animation setDuration:0.2];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithControlPoints:.4f :1.3f :1.f :1.f]];
        [self.kl_badge.layer addAnimation:animation forKey:@"bounceAnimation"];
    }
    
    self.kl_badge.text = self.kl_badgeValue;
    
    NSTimeInterval duration = animated ? 0.2 : 0;
    [UIView animateWithDuration:duration animations:^{
        [self kl_updateBadgeFrame];
    }];
}

- (void)kl_updateBadgeFrame
{
    CGSize expectedLabelSize = [self kl_badgeExpectedSize];
    
    CGFloat minHeight = expectedLabelSize.height;
    
    minHeight = (minHeight < self.kl_badgeMinSize) ? self.kl_badgeMinSize : expectedLabelSize.height;
    CGFloat minWidth = expectedLabelSize.width;
    CGFloat padding = self.kl_badgePadding;
    
    minWidth = (minWidth <= minHeight) ? minHeight : expectedLabelSize.width + 5; // 扩展5pt，是文本左右间距增大
    self.kl_badge.frame = CGRectMake(self.kl_badgeX, self.kl_badgeY, minWidth + padding, minHeight + padding);
    self.kl_badge.layer.cornerRadius = (minHeight + padding) / 2;
    self.kl_badge.layer.masksToBounds = YES;
}

- (UILabel *)kl_duplicateLabel:(UILabel *)labelToCopy
{
    UILabel *duplicateLabel = [[UILabel alloc] initWithFrame:labelToCopy.frame];
    duplicateLabel.text = labelToCopy.text;
    duplicateLabel.font = labelToCopy.font;
    
    return duplicateLabel;
}

- (void)kl_removeBadge
{
    [UIView animateWithDuration:0.2 animations:^{
        self.kl_badge.transform = CGAffineTransformMakeScale(0, 0);
    } completion:^(BOOL finished) {
        [self.kl_badge removeFromSuperview];
        self.kl_badge = nil;
    }];
}

- (UILabel*)kl_badge
{
    return objc_getAssociatedObject(self, @selector(kl_badge));
}

- (void)setKl_badge:(UILabel *)kl_badge
{
    objc_setAssociatedObject(self, @selector(kl_badge), kl_badge, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)kl_badgeValue
{
    return objc_getAssociatedObject(self, @selector(kl_badgeValue));
}

- (void)setKl_badgeValue:(NSString *)kl_badgeValue
{
    objc_setAssociatedObject(self, @selector(kl_badgeValue), kl_badgeValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if ((!kl_badgeValue || [kl_badgeValue isEqualToString:@""] || [kl_badgeValue isEqualToString:@"0"]) && self.kl_shouldHideBadgeAtZero) {
        [self kl_removeBadge];
    } else if (!self.kl_badge) {
        // Create a new badge because not existing
        self.kl_badge = [[UILabel alloc] initWithFrame:CGRectMake(self.kl_badgeX, self.kl_badgeY, 20, 20)];
        self.kl_badge.textColor            = self.kl_badgeTextColor;
        self.kl_badge.backgroundColor      = self.kl_badgeBGColor;
        self.kl_badge.font                 = self.kl_badgeFont;
        self.kl_badge.textAlignment        = NSTextAlignmentCenter;
        [self kl_badgeInit];
        [self addSubview:self.kl_badge];
        [self kl_updateBadgeValueAnimated:NO];
    } else {
        [self kl_updateBadgeValueAnimated:YES];
    }
}

- (UIColor *)kl_badgeBGColor
{
    return objc_getAssociatedObject(self, @selector(kl_badgeBGColor));
}

- (void)setKl_badgeBGColor:(UIColor *)kl_badgeBGColor
{
    objc_setAssociatedObject(self, @selector(kl_badgeBGColor), kl_badgeBGColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.kl_badge) {
        [self kl_refreshBadge];
    }
}

- (UIColor *)kl_badgeTextColor
{
    return objc_getAssociatedObject(self, @selector(kl_badgeTextColor));
}

- (void)setKl_badgeTextColor:(UIColor *)kl_badgeTextColor
{
    objc_setAssociatedObject(self, @selector(kl_badgeTextColor), kl_badgeTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.kl_badge) {
        [self kl_refreshBadge];
    }
}

- (UIFont *)kl_badgeFont
{
    return objc_getAssociatedObject(self, @selector(kl_badgeFont));
}

- (void)setKl_badgeFont:(UIFont *)kl_badgeFont
{
    objc_setAssociatedObject(self, @selector(kl_badgeFont), kl_badgeFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.kl_badge) {
        [self kl_refreshBadge];
    }
}

- (CGFloat)kl_badgePadding
{
    NSNumber *number = objc_getAssociatedObject(self, @selector(kl_badgePadding));
    return number.floatValue;
}

- (void)setKl_badgePadding:(CGFloat)kl_badgePadding
{
    NSNumber *number = [NSNumber numberWithDouble:kl_badgePadding];
    objc_setAssociatedObject(self, @selector(kl_badgePadding), number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.kl_badge) {
        [self kl_updateBadgeFrame];
    }
}

- (CGFloat)kl_badgeMinSize
{
    NSNumber *number = objc_getAssociatedObject(self, @selector(kl_badgeMinSize));
    return number.floatValue;
}

- (void)setKl_badgeMinSize:(CGFloat)kl_badgeMinSize
{
    NSNumber *number = [NSNumber numberWithDouble:kl_badgeMinSize];
    objc_setAssociatedObject(self, @selector(kl_badgeMinSize), number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.kl_badge) {
        [self kl_updateBadgeFrame];
    }
}

- (CGFloat)kl_badgeX
{
    NSNumber *number = objc_getAssociatedObject(self, @selector(kl_badgeX));
    return number.floatValue;
}

- (void)setKl_badgeX:(CGFloat)kl_badgeX
{
    NSNumber *number = [NSNumber numberWithDouble:kl_badgeX];
    objc_setAssociatedObject(self, @selector(kl_badgeX), number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.kl_badge) {
        [self kl_updateBadgeFrame];
    }
}

- (CGFloat)kl_badgeY
{
    NSNumber *number = objc_getAssociatedObject(self, @selector(kl_badgeY));
    return number.floatValue;
}

- (void)setKl_badgeY:(CGFloat)kl_badgeY
{
    NSNumber *number = [NSNumber numberWithDouble:kl_badgeY];
    objc_setAssociatedObject(self, @selector(kl_badgeY), number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.kl_badge) {
        [self kl_updateBadgeFrame];
    }
}

- (BOOL)kl_shouldHideBadgeAtZero
{
    NSNumber *number = objc_getAssociatedObject(self, @selector(kl_shouldHideBadgeAtZero));
    return number.boolValue;
}

- (void)setKl_shouldHideBadgeAtZero:(BOOL)kl_shouldHideBadgeAtZero
{
    NSNumber *number = [NSNumber numberWithBool:kl_shouldHideBadgeAtZero];
    objc_setAssociatedObject(self, @selector(kl_shouldHideBadgeAtZero), number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)kl_shouldAnimateBadge
{
    NSNumber *number = objc_getAssociatedObject(self, @selector(kl_shouldAnimateBadge));
    return number.boolValue;
}

- (void)setKl_shouldAnimateBadge:(BOOL)kl_shouldAnimateBadge
{
    NSNumber *number = [NSNumber numberWithBool:kl_shouldAnimateBadge];
    objc_setAssociatedObject(self, @selector(kl_shouldAnimateBadge), number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// MARK: - 快捷事件注册
- (void)kl_setTapCompletion:(void (^)(UITapGestureRecognizer *tapGesture))completion
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, @selector(kl_setTapCompletion:));
    if (gesture == nil) {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        objc_setAssociatedObject(self, @selector(kl_setTapCompletion:), gesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self addGestureRecognizer:gesture];
    }
    objc_setAssociatedObject(self, @selector(tapGesture:), completion, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)tapGesture:(UITapGestureRecognizer *)gesture
{
    void (^block)(UITapGestureRecognizer *tapGesture) = objc_getAssociatedObject(self, @selector(tapGesture:));
    if (block) block(gesture);
}

- (void)kl_setLongPressCompletion:(void (^)(UILongPressGestureRecognizer *tapGesture))completion
{
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *gesture = objc_getAssociatedObject(self, @selector(kl_setLongPressCompletion:));
    if (gesture == nil) {
        gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, @selector(kl_setLongPressCompletion:), completion, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    objc_setAssociatedObject(self, @selector(longPressGesture:), completion, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)longPressGesture:(UILongPressGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        void (^block)(UILongPressGestureRecognizer *tapGesture) = objc_getAssociatedObject(self, @selector(longPressGesture:));
        if (block) block(gesture);
    }
}

// MARK: - 快捷遍历
- (UIViewController *)kl_controller
{
    UIResponder *responder = self.nextResponder;
    do {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = responder.nextResponder;
    }
    while (responder);
    return nil;
}

- (UIView *)kl_subviewOfClass:(Class)cls
{
    for (UIView * subView in self.subviews) {
        if ([subView isKindOfClass:cls]) return subView;
    }
    return nil;
}

- (NSArray <UIView *> *)kl_subviewsOfClass:(Class)cls {
    NSMutableArray *array = [NSMutableArray array];
    for (UIView * subView in self.subviews) {
        if ([subView isKindOfClass:cls]) {
            [array addObject:subView];
        }
    }
    return array;
}

@end
