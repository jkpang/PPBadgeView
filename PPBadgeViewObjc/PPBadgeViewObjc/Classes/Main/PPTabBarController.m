//
//  PPTabBarController.m
//  PPBadgeViewObjc
//
//  Created by AndyPang on 2017/6/17.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

#import "PPTabBarController.h"
#import "PPViewController1.h"
#import "PPViewController2.h"
#import "PPViewController3.h"
#import "PPViewController4.h"
#import "PPBadgeView.h"

@interface PPTabBarController ()

@end

@implementation PPTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITabBarItem *appearance = [UITabBarItem appearance];
    [appearance setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor]} forState:UIControlStateSelected];
    
    [self setupChildViewControllers];
}


/**
 初始化所有的子控制器
 */
- (void)setupChildViewControllers
{
    PPViewController1 *viewController1 = [[PPViewController1 alloc] init];
    [self setupOneChildViewController:viewController1 title:@"点餐" image:@"dinner" selectedImage:@"dinner_1"];
    
    PPViewController2 *viewController2 = [[PPViewController2 alloc] init];
    [self setupOneChildViewController:viewController2 title:@"订单" image:@"order" selectedImage:@"order_1"];
    
    PPViewController3 *viewController3 = [[PPViewController3 alloc] init];
    [self setupOneChildViewController:viewController3 title:@"充值" image:@"top_up" selectedImage:@"top_up_1"];
    
    PPViewController4 *viewController4 = [[PPViewController4 alloc] init];
    [self setupOneChildViewController:viewController4 title:@"我的" image:@"my" selectedImage:@"my_1"];
    
}

- (void)setupOneChildViewController:(UIViewController *)VC title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    VC.tabBarItem.title = title;
    VC.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    VC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:[[UINavigationController alloc] initWithRootViewController:VC]];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [VC.tabBarItem pp_addDotWithColor:nil];
//    });
    
}

@end
