//
//  UILabel+KLExtension.h
//  KLCategory
//
//  Created by Logic on 2019/12/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (KLExtension)

/// 设置字间距
- (void)kl_setColumnspace:(CGFloat)columnspace;

/// 设置行间距
- (void)kl_setRowspace:(CGFloat)rowspace;

@end

NS_ASSUME_NONNULL_END
