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

@property (strong, nonatomic) PPBadgeLabel *badgeLabel;
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
    [self.headerView pp_moveBadgeWithX:-1 Y:1];
    
    // 2. 给cell添加badge
    self.badgeLabel.backgroundColor = kRandomColor;
    self.badgeLabel.text = [NSString stringWithFormat:@"%d",arc4random()%300];
    self.badgeLabel.p_right = [UIScreen mainScreen].bounds.size.width-15;
    self.badgeLabel.p_centerY = self.p_height * 0.5;
    [self.contentView addSubview:self.badgeLabel];
}
#pragma mark - lazy
- (PPBadgeLabel *)badgeLabel
{
    if (!_badgeLabel) {
        _badgeLabel = [PPBadgeLabel defaultBadgeLabel];
    }
    return _badgeLabel;
}


@end
