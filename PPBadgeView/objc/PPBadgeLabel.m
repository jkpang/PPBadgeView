//
//  PPBadgeLabel.m
//  PPBadgeViewObjc
//
//  Created by AndyPang on 2017/6/17.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

/*
 *********************************************************************************
 *
 * Weibo : jkpang-庞 ( http://weibo.com/jkpang )
 * Email : jkpang@outlook.com
 * QQ 群 : 323408051
 * GitHub: https://github.com/jkpang
 *
 *********************************************************************************
 */

#import "PPBadgeLabel.h"
#import "UIView+PPBadgeView.h"

@interface PPBadgeLabel ()

@end

@implementation PPBadgeLabel

+ (instancetype)defaultBadgeLabel
{
    // 默认为系统tabBarItem的Badge大小
    return [[self alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.textColor = [UIColor whiteColor];
    self.font = [UIFont systemFontOfSize:13];
    self.textAlignment = NSTextAlignmentCenter;
    self.layer.cornerRadius = self.p_height * 0.5;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor colorWithRed:1.00 green:0.17 blue:0.15 alpha:1.00];
    self.flexMode = PPBadgeViewFlexModeTail;
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    // 根据内容调整label的宽度
    CGFloat stringWidth = [self widthForString:text font:self.font height:self.p_height];
    if (self.p_height > stringWidth + self.p_height*10/18) {
        self.p_width = self.p_height;
        return;
    }
    self.p_width = self.p_height*5/18/*left*/ + stringWidth + self.p_height*5/18/*right*/;
}

- (CGFloat)widthForString:(NSString *)string font:(UIFont *)font height:(CGFloat)height
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX,height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size.width;
}

@end
