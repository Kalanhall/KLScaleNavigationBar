//
//  UIButton+KLLayout.m
//  KLCategory
//
//  Created by Logic on 2019/11/25.
//

#import "UIButton+KLExtension.h"
#import <objc/runtime.h>

@implementation UIButton (KLExtension)

- (void)kl_layoutWithStyle:(KLLayoutStyle)Style margin:(CGFloat)margin {
    
    [self.superview layoutIfNeeded];
    NSAssert(self.superview != nil, @"请先将按钮添加到父视图");
    NSAssert(!CGRectEqualToRect(self.bounds, CGRectZero), @"self.frame == CGRectZero");
    
    CGFloat imgWidth = self.imageView.bounds.size.width;
    CGFloat imgHeight = self.imageView.bounds.size.height;
    CGFloat labWidth = self.titleLabel.bounds.size.width;
    CGFloat labHeight = self.titleLabel.bounds.size.height;
    CGSize textSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (labWidth < frameSize.width) {
        labWidth = frameSize.width;
    }
    CGFloat kMargin = margin * 0.5;
    switch (Style) {
        case KLLayoutStyleImageLeft:      // 图左字右
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, -kMargin, 0, kMargin)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, kMargin, 0, -kMargin)];
            break;
        case KLLayoutStyleImageRight:  // 图右字左
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, labWidth + kMargin, 0, -labWidth - kMargin)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -imgWidth - kMargin, 0, imgWidth + kMargin)];
            break;
        case KLLayoutStyleImageTop:    // 图上字下
            [self setImageEdgeInsets:UIEdgeInsetsMake(0,0, labHeight + margin, -labWidth)];
            
            [self setTitleEdgeInsets:UIEdgeInsetsMake(imgHeight + margin, -imgWidth, 0, 0)];
            break;
        case KLLayoutStyleImageBottom: // 图下字上
            [self setImageEdgeInsets:UIEdgeInsetsMake(labHeight + margin,0, 0, -labWidth)];
            
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -imgWidth, imgHeight + margin, 0)];
            
            break;
        default:
            break;
    }
}

- (void)kl_controlEvents:(UIControlEvents)events completion:(void (^)(UIButton *sender))completion
{
    objc_setAssociatedObject(self, @selector(kl_controlEvents:completion:), completion, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(touchUpInside:) forControlEvents:events];
}

- (void)touchUpInside:(UIButton *)sender
{
    void (^block)(UIButton *sender) = objc_getAssociatedObject(self, @selector(kl_controlEvents:completion:));
    if (block) block(sender);
}

@end
