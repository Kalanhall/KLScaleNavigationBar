//
//  UIView+KLExtensiton.m
//  KLCategory
//
//  Created by Logic on 2019/12/2.
//

#import "UIView+KLExtensiton.h"

@implementation UIView (KLExtensiton)

- (CGFloat)x
{ return  self.frame.origin.x; }

- (CGFloat)y
{ return  self.frame.origin.y; }

- (CGFloat)w
{ return  self.frame.size.width; }

- (CGFloat)h
{ return  self.frame.size.height; }

- (CGSize)size
{ return  self.frame.size; }

- (CGFloat)centerX
{ return  self.center.x; }

- (CGFloat)centerY
{ return  self.center.y; }

@end
