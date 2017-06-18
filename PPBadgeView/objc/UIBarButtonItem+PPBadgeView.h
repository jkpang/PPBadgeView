//
//  UIBarButtonItem+PPBadgeView.h
//  PPBadgeViewObjc
//
//  Created by AndyPang on 2017/6/17.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PPBadgeLabel;
@interface UIBarButtonItem (PPBadgeView)

/**
 给控件添加带文本内容的Badge, 默认红色
 */
- (void)pp_addBadgeWithText:(NSString *)text;
/**
 给控件添加带整形数字的Badge, 默认红色
 */
- (void)pp_addBadgeWithNumber:(NSInteger)number;
/**
 给控件添加带颜色的小圆点, 默认红色
 */
- (void)pp_addDotWithColor:(UIColor *)color;

/**
 设置Badge的高度
 (因为Badge宽度是动态可变的,改变Badge的高度,其宽度也按高度的比例变化,方便布局)
 
 @param points 高度的尺寸
 */
- (void)pp_setBadgeHeightPoints:(CGFloat)points;

/**
 设置Badge在控件上的偏移量, Badge的中心默认为其父视图的右上角
 
 @param x X轴偏移量 (x<0: 左移, x>0: 右移)
 @param y Y轴偏移量 (y<0: 上移, y>0: 下移)
 */
- (void)pp_moveBadgeWithX:(CGFloat)x Y:(CGFloat)y;

/**
 设置Bage的属性
 */
- (void)pp_setBadgeLabelAttributes:(void(^)(PPBadgeLabel *badgeLabel))attributes;

/**
 显示Badge
 */
- (void)pp_showBadge;

/**
 隐藏Badge
 */
- (void)pp_hiddenBadge;

#pragma mark - 数字增加/减少, 注意:以下方法只适用于Badge内容为纯数字的情况
- (void)pp_increase;
- (void)pp_increaseBy:(NSInteger)number;
- (void)pp_decrease;
- (void)pp_decreaseBy:(NSInteger)number;
@end
