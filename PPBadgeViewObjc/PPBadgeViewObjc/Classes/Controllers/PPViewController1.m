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
    
    /**
     iOS11系统下 -(void)viewDidLoad中获取不到UIBarButtonItem的实例,demo为了演示效果做了0.001s的延时操作,
     在实际开发中,badge的显示是在网络请求成功/推送之后,所以不用担心获取不到UIBarButtonItem添加不了badge
     */
    if (kSystemVersion >= 11) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setupBadges];
        });
        return;
    }
    
    [self setupBadges];
}

#pragma mark - Badges Example
- (void)setupBadges
{
    [self.tabBarItem pp_addBadgeWithText:@"99+"];
    
    // 1.给UIBarButtonItem添加badge
    // 1.1 左边
    [self.navigationItem.leftBarButtonItem pp_addBadgeWithNumber:1];
    // 调整badge大小
//    [self.navigationItem.leftBarButtonItem pp_setBadgeHeightPoints:25];
    // 调整badge的位置
//    [self.navigationItem.leftBarButtonItem pp_moveBadgeWithX:-7 Y:5];
    
    // 自定义badge的属性: 字体大小/颜色, 背景颜色...(默认系统字体13,白色,背景色为系统badge红色)
    [self.navigationItem.leftBarButtonItem pp_setBadgeLabelAttributes:^(PPBadgeLabel *badgeLabel) {
        badgeLabel.backgroundColor = [UIColor redColor];
//        badgeLabel.font =  [UIFont systemFontOfSize:13];
//        badgeLabel.textColor = [UIColor blueColor];
    }];
    
    // 1.2 右边
    [self.navigationItem.rightBarButtonItem pp_addDotWithColor:nil];
//    [self.navigationItem.rightBarButtonItem pp_moveBadgeWithX:-5 Y:0];
    
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
