//
//  PPViewController1.m
//  PPBadgeViewObjc
//
//  Created by AndyPang on 2017/6/17.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

#import "PPViewController1.h"
#import "PPBadgeView.h"

@interface PPViewController1 ()

@end

@implementation PPViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tabBarItem pp_setBadgeLabelAttributes:^(PPBadgeLabel *badgeLabel) {
//        badgeLabel.backgroundColor = [UIColor blueColor];
    }];
    [self.tabBarItem pp_addBadgeWithNumber:244];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
