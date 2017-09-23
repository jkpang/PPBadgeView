//
//  PPTabBarController.m
//  PPBadgeViewObjc
//
//  Created by AndyPang on 2017/6/17.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

#import "PPTabBarController.h"
#import "PPViewController1.h"
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
    
    /**
     tabBarVC的 -(void)viewDidLoad中获取不到tabBarItem实例,demo为了演示效果做了0.01s的延时操作,
     在实际开发中,badge的显示是在网络请求成功/推送之后,所以不用担心获取不到tabBarItem添加不了badge
     */
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 给UITabBarItem添加badge
        [viewController1.tabBarItem pp_addBadgeWithText:@"99+"];      
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
