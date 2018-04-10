//
//  UIView+PPBadgeView.m
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
    [self pp_showBadge];
    self.badgeLabel.text = text;
}

- (void)pp_addBadgeWithNumber:(NSInteger)number
{
    if (number <= 0) {
        [self pp_addBadgeWithText:@"0"];
        [self pp_hiddenBadge];
        return;
    }
    [self pp_addBadgeWithText:[NSString stringWithFormat:@"%ld",number]];
}

- (void)pp_addDotWithColor:(UIColor *)color
{
    [self pp_addBadgeWithText:nil];
    [self pp_setBadgeHeight:8];
    if (color) {
        self.badgeLabel.backgroundColor = color;
    }
}

- (void)pp_moveBadgeWithX:(CGFloat)x Y:(CGFloat)y
{
    [self lazyLoadBadgeLabel];
    
    self.badgeLabel.offset = CGPointMake(x, y);
    
    self.badgeLabel.p_y = -self.badgeLabel.p_height*0.5/*badge的y坐标*/ + y;
    
    switch (self.badgeLabel.flexMode) {
        case PPBadgeViewFlexModeHead: // 1. 左伸缩  <==●
            self.badgeLabel.p_right = self.badgeLabel.superview.p_width + self.badgeLabel.p_height*0.5 + x;
            break;
        case PPBadgeViewFlexModeTail: // 2. 右伸缩 ●==>
            self.badgeLabel.p_x = (self.p_width - self.badgeLabel.p_height*0.5)/*badge的x坐标*/ + x;
            break;
        case PPBadgeViewFlexModeMiddle: // 3. 左右伸缩  <=●=>
            self.badgeLabel.center = CGPointMake(self.p_width+x, y);
            break;
    }
}

- (void)pp_setBadgeFlexMode:(PPBadgeViewFlexMode)flexMode
{
    self.badgeLabel.flexMode = flexMode;
    [self pp_moveBadgeWithX:self.badgeLabel.offset.x Y:self.badgeLabel.offset.y];
}

- (void)pp_setBadgeLabelAttributes:(void (^)(PPBadgeLabel *))badgeLabel
{
    [self lazyLoadBadgeLabel];
    badgeLabel ? badgeLabel(self.badgeLabel) : nil;
}

- (void)pp_setBadgeHeight:(CGFloat)height
{
    CGFloat scale = height / self.badgeLabel.p_height;
    self.badgeLabel.transform = CGAffineTransformScale(self.badgeLabel.transform, scale, scale);
}

- (void)pp_showBadge
{
    self.badgeLabel.hidden = NO;
}

- (void)pp_hiddenBadge
{
    self.badgeLabel.hidden = YES;
}

- (void)pp_increase
{
    [self pp_increaseBy:1];
}

- (void)pp_increaseBy:(NSInteger)number
{
    NSInteger result = self.badgeLabel.text.integerValue + number;
    if (result > 0) {
        [self pp_showBadge];
    }
    self.badgeLabel.text = [NSString stringWithFormat:@"%ld",result];
}

- (void)pp_decrease
{
    [self pp_decreaseBy:1];
}

- (void)pp_decreaseBy:(NSInteger)number
{
    NSInteger result = self.badgeLabel.text.integerValue - number;
    if (result <= 0) {
        [self pp_hiddenBadge];
        self.badgeLabel.text = @"0";
        return;
    }
    self.badgeLabel.text = [NSString stringWithFormat:@"%ld",result];
}

- (void)lazyLoadBadgeLabel
{
    if (!self.badgeLabel) {
        self.badgeLabel = [PPBadgeLabel defaultBadgeLabel];
        self.badgeLabel.center = CGPointMake(self.p_width, 0);
        [self addSubview:self.badgeLabel];
        [self bringSubviewToFront:self.badgeLabel];
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

- (CGFloat)p_right
{
    return self.frame.origin.x + self.frame.size.width;
}
- (void)setP_right:(CGFloat)p_right
{
    CGRect frame = self.frame;
    frame.origin.x = p_right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)p_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}
- (void)setP_bottom:(CGFloat)p_bottom
{
    CGRect frame = self.frame;
    frame.origin.y = p_bottom - frame.size.height;
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
