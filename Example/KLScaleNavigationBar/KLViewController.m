//
//  KLViewController.m
//  KLScaleNavigationBar
//
//  Created by Kalanhall@163.com on 12/04/2019.
//  Copyright (c) 2019 Kalanhall@163.com. All rights reserved.
//

#import "KLViewController.h"
@import KLScaleNavigationBar;
@import KLCategory;
#import "KLRefreshControl.h"

@interface KLViewController () <UITableViewDelegate, UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) KLScaleNavigationBar *navigationBar;
@property (strong, nonatomic) KLRefreshControl *refresh;

@end

@implementation KLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = KLColor(0x7C0700);
    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:UITableViewCell.description];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = UIColor.clearColor;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    // 核心代码
    self.navigationBar = [KLScaleNavigationBar.alloc initWithFrame:CGRectZero scrollView:self.tableView];
    self.navigationBar.bannerHeight = KLAuto(140);
    self.navigationBar.activityBottomFixHeight = 100;
    // 导航栏上部背景（搜索栏以上）
    self.navigationBar.backgroundView.image = [UIImage imageNamed:@"jd02"];
    // 导航栏下部背景（搜索栏）
    self.navigationBar.searchBackgroundView.image = [UIImage imageNamed:@"jd03"];
    // 搜索栏左右图标
    self.navigationBar.searchBarLeftView.image = [UIImage imageNamed:@"jd06"];
    self.navigationBar.searchBarRightView.image = [UIImage imageNamed:@"jd07"];
    // 轮播图底部背景
    self.navigationBar.bannerBackgroundView.image = [UIImage imageNamed:@"jd04"];
    // 活动图
    self.navigationBar.activityView.image = [UIImage imageNamed:@"jd05"];
    
    UIImageView *left = UIImageView.alloc.init;
    left.contentMode = UIViewContentModeLeft;
    self.navigationBar.leftView = left;
    [left setImage:[UIImage imageNamed:@"jd01"]];
    
    UIButton *item1 = [UIButton buttonWithType:UIButtonTypeCustom];
    item1.titleLabel.font = KLAutoBoldFont(8);
    [item1 setImage:[UIImage imageNamed:@"code"] forState:UIControlStateNormal];
    [item1 setTitle:@"扫啊扫" forState:UIControlStateNormal];
    
    UIButton *item2 = [UIButton buttonWithType:UIButtonTypeCustom];
    item2.titleLabel.font = KLAutoBoldFont(8);
    [item2 setImage:[UIImage imageNamed:@"msg"] forState:UIControlStateNormal];
    [item2 setTitle:@"消息" forState:UIControlStateNormal];
    self.navigationBar.rightViews = @[item2, item1];
    
    [self.navigationBar layoutIfNeeded];
    [item1 kl_layoutWithStyle:KLLayoutStyleImageTop margin:3];
    [item2 kl_layoutWithStyle:KLLayoutStyleImageTop margin:3];
    [self.view addSubview:self.navigationBar];
    
    __weak typeof(self) weakself = self;
    self.navigationBar.searchBarDidBeginEditing = ^{
        
    };
    
    self.refresh = [KLRefreshControl.alloc initWithTargrt:self refreshAction:@selector(refreshcallback)];
    [self.tableView addSubview:self.refresh];
}

- (void)refreshcallback
{
    [self.refresh beginRefreshing];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.refresh endRefreshing];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UITableViewCell.description];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // 随便添加个视图演示视差效果
    cell.backgroundColor = UIColor.clearColor;
    UIView *view = UIView.alloc.init;
    view.backgroundColor = UIColor.orangeColor;
    [cell.contentView addSubview:view];
    view.frame = CGRectMake(10, 0, self.view.bounds.size.width - 10 * 2, KLAuto(140));
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KLAuto(140);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return UIView.new;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return UIView.new;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.navigationBar scaleBarWithRightSpace:80 refreshHeight:self.refresh.kl_height];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    // 京东的骚操作，刷新控件回弹距离，延时才能成功设置滚动距离
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.refresh.isRefreshing && self.refresh.hidden == NO) {
            [self.tableView setContentOffset:(CGPoint){0, -self.tableView.contentInset.top + 20} animated:YES];
        }
    });
}


@end
