//
//  UIView+PPBadgeView.m
//  PPBadgeViewObjc
//
//  Created by AndyPang on 2017/6/17.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

#import "UIView+PPBadgeView.h"
#import "PPBadgeLabel.h"
#import <objc/runtime.h>

static NSString *const kBadgeLabel = @"kBadgeLabel";

@interface UIView ()

@property (nonatomic, strong) PPBadgeLabel *badgeLabel;

@end

@implementation UIView (PPBadgeView)

- (void)pp_addBadgeWithText:(NSString *)text
{
    [self lazyLoadBadgeLabel];
    self.badgeLabel.text = text;
    [self addSubview:self.badgeLabel];
    [self bringSubviewToFront:self.badgeLabel];
}

- (void)pp_addBadgeWithNumber:(NSInteger)number
{
    [self pp_addBadgeWithText:[NSString stringWithFormat:@"%ld",number]];
}

- (void)pp_addDotWithColor:(UIColor *)color
{
    [self pp_addBadgeWithText:nil];
    [self pp_setBadgeHeightPoints:8];
    if (color) {
        self.badgeLabel.backgroundColor = color;
    }
}

- (void)pp_setBadgeHeightPoints:(CGFloat)points
{
    [self lazyLoadBadgeLabel];
    CGFloat scale = points/self.badgeLabel.p_height;
    self.badgeLabel.transform = CGAffineTransformMakeScale(scale, scale);
}

- (void)pp_moveBadgeWithX:(CGFloat)x Y:(CGFloat)y
{
    [self lazyLoadBadgeLabel];
    // 在调整位置之前恢复原位, 避免多次调用此方法导致偏移量叠加
    self.badgeLabel.center = CGPointMake(self.p_width, 0);
    self.badgeLabel.p_centerX += x;
    self.badgeLabel.p_centerY += y;
}

- (void)pp_setBadgeLabelAttributes:(void (^)(PPBadgeLabel *))badgeLabel
{
    [self lazyLoadBadgeLabel];
    badgeLabel ? badgeLabel(self.badgeLabel) : nil;
}

- (void)pp_showBadge
{
    self.badgeLabel.hidden = NO;
}

- (void)pp_hiddenBadge
{
    self.badgeLabel.hidden = YES;
}

- (void)lazyLoadBadgeLabel
{
    if (!self.badgeLabel) {
        self.badgeLabel = [PPBadgeLabel defaultBadgeLabel];
        self.badgeLabel.center = CGPointMake(self.p_width, 0);
        self.badgeLabel.layer.cornerRadius = self.badgeLabel.p_height * 0.5;
        self.badgeLabel.clipsToBounds = YES;
    }
}

#pragma mark - setter/getter
- (PPBadgeLabel *)badgeLabel
{
    return objc_getAssociatedObject(self, &kBadgeLabel);
}

- (void)setBadgeLabel:(PPBadgeLabel *)badgeLabel
{
    objc_setAssociatedObject(self, &kBadgeLabel, badgeLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end


@implementation UIView (Frame)

- (CGFloat)p_x
{
    return self.frame.origin.x;
}
- (void)setP_x:(CGFloat)p_x
{
    CGRect frame = self.frame;
    frame.origin.x = p_x;
    self.frame = frame;
}

- (CGFloat)p_y
{
    return self.frame.origin.y;
}
- (void)setP_y:(CGFloat)p_y
{
    CGRect frame = self.frame;
    frame.origin.y = p_y;
    self.frame = frame;
}

- (CGFloat)p_width
{
    return self.frame.size.width;
}
- (void)setP_width:(CGFloat)p_width
{
    CGRect frame = self.frame;
    frame.size.width = p_width;
    self.frame = frame;
}

- (CGFloat)p_height
{
    return self.frame.size.height;
}
- (void)setP_height:(CGFloat)p_height
{
    CGRect frame = self.frame;
    frame.size.height = p_height;
    self.frame = frame;
}

- (CGFloat)p_centerX
{
    return self.center.x;
}
- (void)setP_centerX:(CGFloat)p_centerX
{
    self.center = CGPointMake(p_centerX, self.center.y);
}

- (CGFloat)p_centerY
{
    return self.center.y;
}
- (void)setP_centerY:(CGFloat)p_centerY
{
    self.center = CGPointMake(self.center.x, p_centerY);
}
@end
