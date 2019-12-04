//
//  UIViewController+LogKLExtension.m
//  KLExtensions
//
//  Created by Logic on 2019/11/20.
//

#import "UIViewController+KLLogExtension.h"
#import <objc/runtime.h>

@implementation UIViewController (KLLogKLExtension)

#ifdef DEBUG
+ (void)load {
    Method m1 = class_getInstanceMethod(self, @selector(viewDidLoad));
    Method m2 = class_getInstanceMethod(self, @selector(ex_viewDidLoad));
    method_exchangeImplementations(m1, m2);
    
    Method m3 = class_getInstanceMethod(self, NSSelectorFromString(@"dealloc"));
    Method m4 = class_getInstanceMethod(self, @selector(ex_dealloc));
    method_exchangeImplementations(m3, m4);
}

- (void)ex_viewDidLoad {
    NSLog(@"%@ viewDidLoad", self);
    [self ex_viewDidLoad];
}

- (void)ex_dealloc {
    NSLog(@"%@ dealloc", self);
    [self ex_dealloc];
}

#endif

@end
