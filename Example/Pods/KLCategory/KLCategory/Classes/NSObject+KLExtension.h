//
//  NSObject+KLExtension.h
//  KLCategory
//
//  Created by Logic on 2019/11/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (KLExtension)

CGFloat ScreenWidth(void);      // 屏幕宽度
CGFloat ScreenHeight(void);     // 屏幕高度

CGFloat Auto(CGFloat origin);   // 等比例缩放计算
CGFloat Auto_Status(void);      // 状态栏高度
CGFloat Auto_Top(void);         // 导航栏高度
CGFloat Auto_Bottom(void);      // 选项栏高度
CGFloat Auto_BottomInset(void); // iPhoneX底部安全高度

BOOL isPhone(void);
BOOL isPhoneX(void);

@end

NS_ASSUME_NONNULL_END
