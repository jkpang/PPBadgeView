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
#import "PPBadgeControl.h"
#import <objc/runtime.h>

static NSString *const kBadgeView = @"kBadgeView";

@interface UIView ()

@end

@implementation UIView (PPBadgeView)

- (void)pp_addBadgeWithText:(NSString *)text
{
    [self pp_showBadge];
    self.badgeView.text = text;
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
    CGFloat defaultHeight = 8.0;
    [self pp_addBadgeWithText:nil];
    self.badgeView.backgroundColor = color;
    self.badgeView.layer.cornerRadius = defaultHeight * 0.5;
    self.badgeView.heightConstraint.constant = defaultHeight;
    
    if (self.badgeView.widthConstraint.relation == NSLayoutRelationEqual) {
        return;
    }
    [self.badgeView removeConstraint:self.badgeView.widthConstraint];
    NSLayoutConstraint *constraintW = [NSLayoutConstraint constraintWithItem:self.badgeView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.badgeView attribute:(NSLayoutAttributeHeight) multiplier:1.0 constant:0];
    [self.badgeView addConstraint:constraintW];
}

- (void)pp_moveBadgeWithX:(CGFloat)x Y:(CGFloat)y
{
    self.badgeView.offset = CGPointMake(x, y);
    self.badgeView.centerYConstraint.constant = y;
    switch (self.badgeView.flexMode) {
        case PPBadgeViewFlexModeHead: // 1. 左伸缩  <==●
        {
            if (self.centerXConstraint) {
                [self removeConstraint:self.centerXConstraint];
            }
            if (self.leadingConstraint) {
                [self removeConstraint:self.leadingConstraint];
            }
            NSLayoutConstraint *trailingConstraint = [NSLayoutConstraint constraintWithItem:self.badgeView attribute:NSLayoutAttributeTrailing relatedBy:(NSLayoutRelationEqual) toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:self.badgeView.heightConstraint.constant*0.5 + x];
            [self addConstraint:trailingConstraint];
            break;
        }
        case PPBadgeViewFlexModeTail: // 2. 右伸缩 ●==>
        {
            if (self.centerXConstraint) {
                [self removeConstraint:self.centerXConstraint];
            }
            if (self.trailingConstraint) {
                [self removeConstraint:self.trailingConstraint];
            }
            NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:self.badgeView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:x - self.badgeView.heightConstraint.constant*0.5];
            [self addConstraint:leadingConstraint];
            break;
        }
            
        case PPBadgeViewFlexModeMiddle: // 3. 左右伸缩  <=●=>
        {
            if (self.leadingConstraint) {
                [self removeConstraint:self.leadingConstraint];
            }
            if (self.trailingConstraint) {
                [self removeConstraint:self.trailingConstraint];
            }
            if (!self.centerXConstraint) {
                NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:self.badgeView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
                [self addConstraint:centerXConstraint];
            }
            self.centerXConstraint.constant = x;
            break;
        }
    }
}

- (void)pp_setBadgeFlexMode:(PPBadgeViewFlexMode)flexMode
{
    self.badgeView.flexMode = flexMode;
    [self pp_moveBadgeWithX:self.badgeView.offset.x Y:self.badgeView.offset.y];
}

- (void)pp_setBadgeHeight:(CGFloat)height
{
    self.badgeView.layer.cornerRadius = height * 0.5;
    self.badgeView.heightConstraint.constant = height;
    
    if (self.badgeView.widthConstraint.relation == NSLayoutRelationGreaterThanOrEqual) {
        return;
    }
    [self.badgeView removeConstraint:self.badgeView.widthConstraint];
    NSLayoutConstraint *constraintW = [NSLayoutConstraint constraintWithItem:self.badgeView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.badgeView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    [self.badgeView addConstraint:constraintW];
}

- (void)pp_showBadge
{
    self.badgeView.hidden = NO;
}

- (void)pp_hiddenBadge
{
    self.badgeView.hidden = YES;
}

- (void)pp_increase
{
    [self pp_increaseBy:1];
}

- (void)pp_increaseBy:(NSInteger)number
{
    NSInteger result = self.badgeView.text.integerValue + number;
    if (result > 0) {
        [self pp_showBadge];
    }
    self.badgeView.text = [NSString stringWithFormat:@"%ld",result];
}

- (void)pp_decrease
{
    [self pp_decreaseBy:1];
}

- (void)pp_decreaseBy:(NSInteger)number
{
    NSInteger result = self.badgeView.text.integerValue - number;
    if (result <= 0) {
        [self pp_hiddenBadge];
        self.badgeView.text = @"0";
        return;
    }
    self.badgeView.text = [NSString stringWithFormat:@"%ld",result];
}

- (void)addBadgeViewLayout
{
    [self.badgeView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSLayoutConstraint *constraintCX = [NSLayoutConstraint constraintWithItem:self.badgeView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:(NSLayoutAttributeTrailing) multiplier:1.0 constant:0];
    NSLayoutConstraint *constraintCY = [NSLayoutConstraint constraintWithItem:self.badgeView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:(NSLayoutAttributeTop) multiplier:1.0 constant:0];
    NSLayoutConstraint *constraintW = [NSLayoutConstraint constraintWithItem:self.badgeView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.badgeView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    NSLayoutConstraint *constraintH = [NSLayoutConstraint constraintWithItem:self.badgeView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:18];
    [self addConstraints:@[constraintCX, constraintCY]];
    [self.badgeView addConstraints:@[constraintW, constraintH]];
}

#pragma mark - setter/getter

- (PPBadgeControl *)badgeView
{
    PPBadgeControl *badgeView = objc_getAssociatedObject(self, &kBadgeView);
    if (!badgeView) {
        badgeView = [PPBadgeControl defaultBadge];
        [self addSubview:badgeView];
        [self bringSubviewToFront:badgeView];
        [self setBadgeView:badgeView];
        [self addBadgeViewLayout];
    }
    return badgeView;
}

- (void)setBadgeView:(PPBadgeControl *)badgeView
{
    objc_setAssociatedObject(self, &kBadgeView, badgeView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

#pragma mark -------------------------------

@implementation UIView (Constraint)

- (NSLayoutConstraint *)topConstraint
{
    return [self getConstraint:NSLayoutAttributeTop];
}

- (NSLayoutConstraint *)leadingConstraint
{
    return [self getConstraint:NSLayoutAttributeLeading];
}

- (NSLayoutConstraint *)bottomConstraint
{
    return [self getConstraint:NSLayoutAttributeBottom];
}

- (NSLayoutConstraint *)trailingConstraint
{
    return [self getConstraint:NSLayoutAttributeTrailing];
}

- (NSLayoutConstraint *)widthConstraint
{
    return [self getConstraint:NSLayoutAttributeWidth];
}

- (NSLayoutConstraint *)heightConstraint
{
    return [self getConstraint:NSLayoutAttributeHeight];
}

- (NSLayoutConstraint *)centerXConstraint
{
    return [self getConstraint:NSLayoutAttributeCenterX];
}

- (NSLayoutConstraint *)centerYConstraint
{
    return [self getConstraint:NSLayoutAttributeCenterY];
}

- (NSLayoutConstraint *)getConstraint: (NSLayoutAttribute)layoutAttribute
{
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstAttribute == layoutAttribute) {
            return constraint;
        }
    }
    return nil;
}

@end
