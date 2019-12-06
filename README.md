# KLScaleNavigationBar

[![CI Status](https://img.shields.io/travis/Kalanhall@163.com/KLScaleNavigationBar.svg?style=flat)](https://travis-ci.org/Kalanhall@163.com/KLScaleNavigationBar)
[![Version](https://img.shields.io/cocoapods/v/KLScaleNavigationBar.svg?style=flat)](https://cocoapods.org/pods/KLScaleNavigationBar)
[![License](https://img.shields.io/cocoapods/l/KLScaleNavigationBar.svg?style=flat)](https://cocoapods.org/pods/KLScaleNavigationBar)
[![Platform](https://img.shields.io/cocoapods/p/KLScaleNavigationBar.svg?style=flat)](https://cocoapods.org/pods/KLScaleNavigationBar)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.
```ruby

/// 使用
1、第一步需要隐藏导航栏
2、初始化
self.dynamicBar = [KLScaleNavigationBar.alloc initWithScrollView:self.collectionView];
self.dynamicBar.backgroundView.image = xxx; // 导航栏背景图
self.dynamicBar.botView.image = xxx; // 导航栏下方长图，与导航栏背景图一致
self.dynamicBar.topView.image = xxx; // 下拉时显示的活动页，大小与屏幕一致
[self.view addSubview:self.dynamicBar];

// 设置代理调用方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 80为预留导航栏右侧按钮的位置，这里使用的事MJRefresh，self.collectionView.mj_header.mj_h 刷新控件的高度
    [self.dynamicBar dynamicWithRightSpace:80 refreshHeight:self.collectionView.mj_header.mj_h];
}

```

## Requirements

## Installation

KLScaleNavigationBar is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'KLScaleNavigationBar'
```

## Author

Kalanhall@163.com, wujm002@galanz.com

## License

KLScaleNavigationBar is available under the MIT license. See the LICENSE file for more info.
