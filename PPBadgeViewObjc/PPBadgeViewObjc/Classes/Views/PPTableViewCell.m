//
//  PPTableViewCell.m
//  PPBadgeViewObjc
//
//  Created by AndyPang on 2017/6/17.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

#import "PPTableViewCell.h"
#import "PPBadgeView.h"

#define kRandomColor [UIColor colorWithRed:arc4random()%255/255.f green:arc4random()%255/255.f blue:arc4random()%255/255.f alpha:1]


@interface PPTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *headerView;

@end

@implementation PPTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.headerView.layer.cornerRadius = 3;
    
    [self setupBadge];
}

- (void)setupBadge
{
    // 1. 给headeView添加小圆点
    [self.headerView pp_addDotWithColor:kRandomColor];
    [self.headerView pp_setBadgeFlexMode:PPBadgeViewFlexModeHead];
    [self.headerView pp_moveBadgeWithX:-1 Y:1];
}

@end
