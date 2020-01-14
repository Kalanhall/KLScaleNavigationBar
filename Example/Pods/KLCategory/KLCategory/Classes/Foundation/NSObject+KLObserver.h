//
//  NSObject+KLObserver.h
//  KLCategory
//
//  Created by Logic on 2020/1/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (KLObserver)

/// 便捷通知发送方法
/// @param name 通知标识符
- (void)kl_postNotificationName:(NSNotificationName)name object:(nullable id)object;

/// 便捷通知接收方法
///
/// 使用示例：
///
///  [self kl_observerNotificationName:@"name" completion:^(NSNotification *notification) {
///     NSLog(@"%@", notification);
///  }];
///
/// 应用生命周期通知常量
///
///   UIApplicationDidEnterBackgroundNotification ;
///   UIApplicationWillEnterForegroundNotification;
///   UIApplicationDidFinishLaunchingNotification;
///   UIApplicationDidBecomeActiveNotification;
///   UIApplicationWillResignActiveNotification;
///   UIApplicationDidReceiveMemoryWarningNotification;
///   UIApplicationWillTerminateNotification;
///
/// @param name  通知标识符
/// @param completion  属性改变回调
- (void)kl_observerNotificationName:(NSNotificationName)name completion:(nullable void (^)(NSNotification *notification))completion;

/// 自动移除KVO的监听扩展方法
///
/// 使用示例：
///  [self kl_observerObject:self.tableView forKeyPath:@"contentOffset" completion:^(id value) {
///     NSLog(@"%f", [value CGSizeValue].height);
///  }];
/// @param object    监听对象
/// @param keyPath  监听属性
/// @param completion  属性改变回调
- (void)kl_observerObject:(NSObject *)object forKeyPath:(NSString *)keyPath completion:(nullable void (^)(id value))completion;

@end

NS_ASSUME_NONNULL_END
