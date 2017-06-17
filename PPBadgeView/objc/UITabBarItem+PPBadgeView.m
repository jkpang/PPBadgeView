//
//  UITabBarItem+PPBadgeView.m
//  PPBadgeViewObjc
//
//  Created by AndyPang on 2017/6/17.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

#import "UITabBarItem+PPBadgeView.h"
#import "UIView+PPBadgeView.h"

@implementation UITabBarItem (PPBadgeView)

- (void)pp_addBadgeWithText:(NSString *)text
{
    [[self bottomView] pp_moveBadgeWithX:4 Y:3];   // 默认为系统Badge所在的位置
    [[self bottomView] pp_addBadgeWithText:text];
}

- (void)pp_addBadgeWithNumber:(NSInteger)number
{
    [self pp_addBadgeWithText:[NSString stringWithFormat:@"%ld",number]];
}

- (void)pp_addDotWithColor:(UIColor *)color
{
    [[self bottomView] pp_addDotWithColor:color];
}

- (void)pp_setBadgeHeightPoints:(CGFloat)points
{
    [[self bottomView] pp_setBadgeHeightPoints:points];
}

- (void)pp_moveBadgeWithX:(CGFloat)x Y:(CGFloat)y
{
    [[self bottomView] pp_moveBadgeWithX:x Y:y];
}

- (void)pp_setBadgeLabelAttributes:(void(^)(PPBadgeLabel *badgeLabel))badgeLabel
{
    [[self bottomView] pp_setBadgeLabelAttributes:badgeLabel];
}

- (void)pp_showBadge
{
    [[self bottomView] pp_showBadge];
}

- (void)pp_hiddenBadge
{
    [[self bottomView] pp_hiddenBadge];
}

- (UIView *)bottomView
{
    // 通过Xcode视图调试工具找到UITabBarItem原生Badge所在父视图为:UITabBarSwappableImageView
    UIView *tabBarButton = [self valueForKey:@"_view"];
    for (UIView *subView in tabBarButton.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
            return subView;
        }
    }
    return tabBarButton;
}

@end
