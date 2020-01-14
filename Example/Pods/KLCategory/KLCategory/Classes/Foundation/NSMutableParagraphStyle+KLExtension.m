//
//  NSMutableParagraphStyle+KLExtension.m
//  KLCategory
//
//  Created by Logic on 2019/12/17.
//

#import "NSMutableParagraphStyle+KLExtension.h"

@implementation NSMutableParagraphStyle (KLExtension)

+ (instancetype)kl_paragraphStyleWithLineHeight:(CGFloat)lineHeight {
    return [self kl_paragraphStyleWithLineHeight:lineHeight lineBreakMode:NSLineBreakByWordWrapping textAlignment:NSTextAlignmentLeft];
}

+ (instancetype)kl_paragraphStyleWithLineHeight:(CGFloat)lineHeight lineBreakMode:(NSLineBreakMode)lineBreakMode {
    return [self kl_paragraphStyleWithLineHeight:lineHeight lineBreakMode:lineBreakMode textAlignment:NSTextAlignmentLeft];
}

+ (instancetype)kl_paragraphStyleWithLineHeight:(CGFloat)lineHeight lineBreakMode:(NSLineBreakMode)lineBreakMode textAlignment:(NSTextAlignment)textAlignment {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.minimumLineHeight = lineHeight;
    paragraphStyle.maximumLineHeight = lineHeight;
    paragraphStyle.lineBreakMode = lineBreakMode;
    paragraphStyle.alignment = textAlignment;
    return paragraphStyle;
}

@end
