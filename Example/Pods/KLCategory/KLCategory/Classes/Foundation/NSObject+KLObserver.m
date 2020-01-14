//
//  NSObject+KLObserver.m
//  KLCategory
//
//  Created by Logic on 2020/1/7.
//

#import "NSObject+KLObserver.h"
#import <objc/runtime.h>

@interface KLObserverHelper : NSObject

@property (unsafe_unretained, nonatomic) id object; // 当对象释放后仍指向该内存空间
@property (strong, nonatomic) NSString *keyPath;
@property (strong, nonatomic) void (^completion)(id value);

@end

@implementation KLObserverHelper

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([object isEqual:self.object] && self.completion) {
        self.completion([change valueForKey:@"new"]);
    }
}

- (void)notificationCenterCallback:(NSNotification *)notification
{
    if (self.completion) {
        self.completion(notification);
    }
}

- (void)dealloc
{
    // 移除监听属性
    if (self.object && self.keyPath) {
        [self.object removeObserver:self forKeyPath:self.keyPath];
    }
}

@end

@implementation NSObject (KLObserver)

- (void)kl_postNotificationName:(NSNotificationName)name object:(nullable id)object
{
    [NSNotificationCenter.defaultCenter postNotificationName:name object:object];
}

- (void)kl_observerNotificationName:(NSNotificationName)name completion:(void (^)(NSNotification *notification))completion;
{
    KLObserverHelper *observer = KLObserverHelper.alloc.init;
    observer.completion = completion;
    objc_setAssociatedObject(self, NSSelectorFromString(observer.description), observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [NSNotificationCenter.defaultCenter addObserver:observer selector:@selector(notificationCenterCallback:) name:name object:nil];
}

- (void)kl_observerObject:(NSObject *)object forKeyPath:(NSString *)keyPath completion:(void (^)(id value))completion
{
    KLObserverHelper *observer = KLObserverHelper.alloc.init;
    observer.object = object;
    observer.keyPath = keyPath;
    observer.completion = completion;
    objc_setAssociatedObject(self, NSSelectorFromString(observer.description), observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [object addObserver:observer forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:nil];
}

@end
