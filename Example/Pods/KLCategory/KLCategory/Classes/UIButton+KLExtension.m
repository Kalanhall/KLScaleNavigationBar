//
//  UIButton+KLExtension.m
//  KLCategory
//
//  Created by Logic on 2019/11/25.
//

#import "UIButton+KLExtension.h"

@implementation UIButton (KLExtension)

- (void)kl_layoutWithStatus:(KLLayoutStatus)status margin:(CGFloat)margin {
    CGFloat imgWidth = self.imageView.bounds.size.width;
    CGFloat imgHeight = self.imageView.bounds.size.height;
    CGFloat labWidth = self.titleLabel.bounds.size.width;
    CGFloat labHeight = self.titleLabel.bounds.size.height;
    CGSize textSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (labWidth < frameSize.width) {
        labWidth = frameSize.width;
    }
    CGFloat kMargin = margin/2.0;
    switch (status) {
        case KLLayoutStatusNormal:      // 图左字右
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, -kMargin, 0, kMargin)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, kMargin, 0, -kMargin)];
            break;
        case KLLayoutStatusImageRight:  // 图右字左
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, labWidth + kMargin, 0, -labWidth - kMargin)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -imgWidth - kMargin, 0, imgWidth + kMargin)];
            break;
        case KLLayoutStatusImageTop:    // 图上字下
            [self setImageEdgeInsets:UIEdgeInsetsMake(10,0, labHeight + margin, -labWidth)];
            
            [self setTitleEdgeInsets:UIEdgeInsetsMake(imgHeight + margin + 10, -imgWidth, 0, 0)];
            break;
        case KLLayoutStatusImageBottom: // 图下字上
            [self setImageEdgeInsets:UIEdgeInsetsMake(labHeight + margin - 10,0, 0, -labWidth)];
            
            [self setTitleEdgeInsets:UIEdgeInsetsMake(-10, -imgWidth, imgHeight + margin, 0)];
            
            break;
        default:
            break;
    }
}

@end
