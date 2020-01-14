//
//  NSObject+KLCoding.m
//  KLCategory
//
//  Created by Logic on 2020/1/10.
//

#import "NSObject+KLCoding.h"
#import <objc/runtime.h>

@implementation NSObject (KLCoding)

-(void)kl_encode:(NSCoder *)aCoder
{
    // 获取所有的实例变量
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    
    // 遍历
    for (int i = 0; i < count; i ++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        // kvc
        /***
            valueForKey (总体规则 先找相关方法 再找相关变量)
         1. 先找相关方法, 如果相关方法找不到(getName name)
         2. 根据accessInstanceVariablesDirectly类方法来判断
         3. 如果判断是NO,直接执行KVC的valueForUndefineKey(系统跑出一个异常,未定义key)
         4. 如果是YES,继续找相关变量(_name _isName,naame,isName)
         ***/
        id value = [self valueForKey:key];
        // 编码
        [aCoder encodeObject:value forKey:key];
    }
    
    free(ivars);
    
}

-(void)kl_decode:(NSCoder *)aDecoder
{
    // 获取所有的实例变量
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    
    // 遍历
    for (int i = 0; i < count; i ++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        // kvc
        id value = [aDecoder decodeObjectForKey:key];
        // 解码
        [self setValue:value forKey:key];
    }
    
    free(ivars);
}

@end
