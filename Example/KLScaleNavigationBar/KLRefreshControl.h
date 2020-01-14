//
//  KLRefreshControl.h
//  KLHomeService
//
//  Created by Logic on 2020/1/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *KLRefreshNormalTitle  = @"下拉刷新";
static NSString *KLRefreshPullingTitle  = @"继续下拉有惊喜";
static NSString *KLRefreshRefreshingTitle  = @"更新中";

@interface KLRefreshControl : UIRefreshControl

- (instancetype)initWithTargrt:(id)target refreshAction:(SEL)refreshAction;
- (void)endRefreshing;

@end

NS_ASSUME_NONNULL_END
