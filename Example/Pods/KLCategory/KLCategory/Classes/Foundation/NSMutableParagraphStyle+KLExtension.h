//
//  NSMutableParagraphStyle+KLExtension.h
//  KLCategory
//
//  Created by Logic on 2019/12/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableParagraphStyle (KLExtension)

/**
 *  快速创建一个NSMutableParagraphStyle，等同于`kl_paragraphStyleWithLineHeight:lineBreakMode:NSLineBreakByWordWrapping textAlignment:NSTextAlignmentLeft`
 *  @param  lineHeight      行高
 *  @return 一个NSMutableParagraphStyle对象
 */
+ (instancetype)kl_paragraphStyleWithLineHeight:(CGFloat)lineHeight;

/**
 *  快速创建一个NSMutableParagraphStyle，等同于`kl_paragraphStyleWithLineHeight:lineBreakMode:textAlignment:NSTextAlignmentLeft`
 *  @param  lineHeight      行高
 *  @param  lineBreakMode   换行模式
 *  @return 一个NSMutableParagraphStyle对象
 */
+ (instancetype)kl_paragraphStyleWithLineHeight:(CGFloat)lineHeight lineBreakMode:(NSLineBreakMode)lineBreakMode;

/**
 *  快速创建一个NSMutableParagraphStyle
 *  @param  lineHeight      行高
 *  @param  lineBreakMode   换行模式
 *  @param  textAlignment   文本对齐方式
 *  @return 一个NSMutableParagraphStyle对象
 */
+ (instancetype)kl_paragraphStyleWithLineHeight:(CGFloat)lineHeight lineBreakMode:(NSLineBreakMode)lineBreakMode textAlignment:(NSTextAlignment)textAlignment;

@end

NS_ASSUME_NONNULL_END
