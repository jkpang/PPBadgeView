//
//  PPViewController1.m
//  PPBadgeViewObjc
//
//  Created by AndyPang on 2017/6/17.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

#import "PPViewController1.h"
#import "PPBadgeView.h"
#import "PPTableViewCell.h"

@interface PPViewController1 () <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PPViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
    [self setupBadges];
    
}


#pragma mark - Badges Example
- (void)setupBadges
{
    
    // 1. 给UITabBarItem添加badge
    
    /**
     自定义badge的属性: 字体大小/颜色, 背景颜色...(默认系统字体13,白色,背景色为系统badge红色)
     PPBadgeLabel继承UILabel
     */
//    [self.tabBarItem pp_setBadgeLabelAttributes:^(PPBadgeLabel *badgeLabel) {
//        badgeLabel.font =  [UIFont systemFontOfSize:13];
//        badgeLabel.textColor = [UIColor blueColor];
//        badgeLabel.backgroundColor = [UIColor redColor];
//        
//    }];

//    self.tabBarItem.badgeValue = @"99+";
    self.tabBarItem.badgeColor = [UIColor blueColor];
//    [self.tabBarItem pp_addBadgeWithText:@"99+"];
    
    // 2.给UIBarButtonItem添加bage
    // 2.1 左边
    [self.navigationItem.rightBarButtonItem pp_addDotWithColor:nil];
    [self.navigationItem.rightBarButtonItem pp_moveBadgeWithX:-5 Y:0];
    // 2.2 右边
    [self.navigationItem.leftBarButtonItem pp_addBadgeWithNumber:0];
    [self.navigationItem.leftBarButtonItem pp_moveBadgeWithX:-7 Y:5];
    [self.navigationItem.leftBarButtonItem pp_setBadgeLabelAttributes:^(PPBadgeLabel *badgeLabel) {
        badgeLabel.backgroundColor = [UIColor redColor];
    }];
    
}


- (void)setupViews
{
    self.tableView.rowHeight = 60;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PPTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(delete)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add)];
}
- (void)delete
{
    [self.navigationItem.leftBarButtonItem pp_decrease];
}
- (void)add
{
    [self.navigationItem.leftBarButtonItem pp_increase];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    return cell;
}

@end
