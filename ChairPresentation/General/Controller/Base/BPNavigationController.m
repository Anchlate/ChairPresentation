//
//  BPNavigationController.m
//  Converse
//
//  Created by chf on 16/1/19.
//  Copyright © 2016年 baiPeng. All rights reserved.
//

#import "BPNavigationController.h"

@interface BPNavigationController ()

@property(nonatomic, retain)UIView *alphaView;

@end

@implementation BPNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

+ (void)initialize
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    //设置标题文字的颜色
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [navBar setTitleTextAttributes:attrs];
    
}

// overide the method to change the status
#pragma mark preferredStatusBarSstyle
- (UIStatusBarStyle)preferredStatusBarStyle
{
    
    UIViewController* topVC = self.topViewController;
    return [topVC preferredStatusBarStyle];
    
}


#pragma mark navigationBarWithAlpha:backGroundColor:
- (void)navigationBarWithAlpha:(CGFloat)alpha backGroundColor:(UIColor *)backGroundColor
{
    CGRect frame = self.navigationBar.frame;
    self.alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height+20)];
    self.alphaView.backgroundColor = backGroundColor;
    self.alphaView.alpha = alpha;
    [self.view insertSubview:self.alphaView belowSubview:self.navigationBar];
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"bigShadow.png"] forBarMetrics:UIBarMetricsCompact];
    self.navigationBar.layer.masksToBounds = YES;
}

#pragma mark resetBack
- (void)resetting
{
    [self.navigationBar setBarTintColor:NavigationBarDefaultBarTintColor];
    self.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:NavigationBarDefaultTintColor forKey:NSForegroundColorAttributeName];
    self.navigationBar.tintColor = NavigationBarDefaultTitleColor;
    
    self.alphaView.alpha = 1;
    [self.alphaView removeFromSuperview];
    [self.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
