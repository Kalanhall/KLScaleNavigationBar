//
//  KLViewController.m
//  KLScaleNavigationBar
//
//  Created by Kalanhall@163.com on 12/04/2019.
//  Copyright (c) 2019 Kalanhall@163.com. All rights reserved.
//

#import "KLViewController.h"
@import KLScaleNavigationBar;

@interface KLViewController () <UITableViewDelegate, UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) KLScaleNavigationBar *dynamicBar;

@end

@implementation KLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:UITableViewCell.description];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // 核心代码
    self.dynamicBar = [KLScaleNavigationBar.alloc initWithScrollView:self.tableView];
    self.dynamicBar.backgroundView.image = [UIImage imageNamed:@"bot"]; // 导航栏背景图
    self.dynamicBar.botView.image = [UIImage imageNamed:@"bot"]; // 导航栏下方长图，与导航栏背景图一致
    self.dynamicBar.topView.image = [UIImage imageNamed:@"top"]; // 下拉时显示的活动页，大小与屏幕一致
    self.dynamicBar.searchImage = [UIImage imageNamed:@"search"];
    [self.view addSubview:self.dynamicBar];
    
    UIButton *item1 = [UIButton buttonWithType:UIButtonTypeCustom];
    item1.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [item1 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [item1 setImage:[UIImage imageNamed:@"相机"] forState:UIControlStateNormal];
    UIButton *item2 = [UIButton buttonWithType:UIButtonTypeCustom];
    item2.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [item2 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [item2 setImage:[UIImage imageNamed:@"消息"] forState:UIControlStateNormal];
    self.dynamicBar.rightViews = @[item2, item1];
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    left.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [left setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [left setImage:[UIImage imageNamed:@"京东"] forState:UIControlStateNormal];
    self.dynamicBar.leftView = left;
    
    self.dynamicBar.searchBarDidBeginEditing = ^{
        NSLog(@"点击搜索");
    };

}

// 设置代理调用方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 80为预留导航栏右侧按钮的位置，这里使用的事MJRefresh，self.tableView.mj_header.mj_h 刷新控件的高度
    [self.dynamicBar dynamicWithRightSpace:80 refreshHeight:40];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UITableViewCell.description];
    
    // 随便添加个视图演示视差效果
    cell.backgroundColor = UIColor.clearColor;
    UIView *view = UIView.alloc.init;
    view.backgroundColor = UIColor.orangeColor;
    [cell.contentView addSubview:view];
    view.frame = CGRectMake(20, 0, self.view.bounds.size.width - 20 * 2, 80);
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}


@end
