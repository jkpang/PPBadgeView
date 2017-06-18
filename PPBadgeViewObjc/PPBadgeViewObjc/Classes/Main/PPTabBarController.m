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
#import "PPBadgeView.h"

@interface PPTabBarController ()

@end

@implementation PPTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITabBarItem *appearance = [UITabBarItem appearance];
    [appearance setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor]} forState:UIControlStateSelected];
    
    PPViewController1 *viewController1 = [[PPViewController1 alloc] init];
    [self setupOneChildViewController:viewController1 title:@"点餐" image:@"dinner" selectedImage:@"dinner_1"];
    
    PPViewController2 *viewController2 = [[PPViewController2 alloc] init];
    [self setupOneChildViewController:viewController2 title:@"订单" image:@"order" selectedImage:@"order_1"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       
        [viewController1.tabBarItem pp_moveBadgeWithX:4 Y:3];
        [viewController1.tabBarItem pp_addBadgeWithText:@"99+"];
        
        [viewController2.tabBarItem pp_moveBadgeWithX:4 Y:3];
        [viewController2.tabBarItem pp_addDotWithColor:nil];
        
    });
}

- (void)setupOneChildViewController:(UIViewController *)VC title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    VC.tabBarItem.title = title;
    VC.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    VC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:[[UINavigationController alloc] initWithRootViewController:VC]];
}

@end
