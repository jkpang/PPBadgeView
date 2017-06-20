//
//  UITabBarItem+PPBadgeView.swift
//  PPBadgeViewSwift
//
//  Created by AndyPang on 2017/6/19.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

/*
 *********************************************************************************
 *
 * Weibo : jkpang-庞 (http://weibo.com/jkpang)
 * Email : jkpang@outlook.com
 * QQ 群 : 323408051
 * GitHub: https://github.com/jkpang
 *
 *********************************************************************************
 */

import UIKit

public extension UITabBarItem {
    
    /// 添加带文本内容的Badge, 默认右上角, 红色, 18pts
    ///
    /// - Parameter text: 文本字符串
    public func pp_addBadge(text: String) {
        _bottomView.pp_addBadge(text: text)
        _bottomView.pp_moveBadge(x: 4, y: 3)
    }
    
    /// 添加带数字的Badge, 默认右上角,红色,18pts
    ///
    /// - Parameter number: 整形数字
    public func pp_addBadge(number: Int) {
        _bottomView.pp_addBadge(number: number)
        _bottomView.pp_moveBadge(x: 4, y: 3)
    }
    
    /// 添加带颜色的小圆点, 默认右上角, 红色, 8pts
    ///
    /// - Parameter color: 颜色
    public func pp_addDot(color: UIColor?) {
        _bottomView.pp_addDot(color: color)
    }
    
    /// 设置Badge的偏移量, Badge中心点默认为其父视图的右上角
    ///
    /// - Parameters:
    ///   - x: X轴偏移量 (x<0: 左移, x>0: 右移)
    ///   - y: Y轴偏移量 (y<0: 上移, y>0: 下移)
    public func pp_moveBadge(x: CGFloat, y: CGFloat) {
        _bottomView.pp_moveBadge(x: x, y: y)
    }
    
    /// 设置Badge的高度,因为Badge宽度是动态可变的,通过改变Badge高度,其宽度也按比例变化,方便布局
    /// (注意: 此方法需要将Badge添加到控件上后再调用!!!)
    ///
    /// - Parameter points: 高度大小
    public func pp_setBadgeHeight(points: CGFloat) {
        _bottomView.pp_setBadgeHeight(points: points)
    }
    
    /// 设置Bage的属性
    ///
    /// - Parameter attributes: 将badgeLabel对象回调出来的闭包
    public func pp_setBadgeLabel(attributes: (PPBadgeLabel)->()) {
        _bottomView.pp_setBadgeLabel(attributes: attributes)
    }
    
    /// 显示Badge
    public func pp_showBadge() {
        _bottomView.pp_showBadge()
    }
    
    /// 隐藏Badge
    public func pp_hiddenBadge() {
        _bottomView.pp_hiddenBadge()
    }
    
    // MARK: - 数字增加/减少, 注意:以下方法只适用于Badge内容为纯数字的情况
    /// badge数字加1
    public func pp_increase() {
        _bottomView.pp_increase()
    }
    
    /// badge数字加number
    public func pp_increaseBy(number: Int) {
        _bottomView.pp_increaseBy(number: number)
    }
    
    /// badge数字加1
    public func pp_decrease() {
        _bottomView.pp_decrease()
    }
    
    /// badge数字减number
    public func pp_decreaseBy(number: Int) {
        _bottomView.pp_decreaseBy(number: number)
    }
    
    /// 通过Xcode视图调试工具找到UITabBarItem原生Badge所在父视图为:UITabBarSwappableImageView
    private var _bottomView: UIView {
        let tabBarButton:UIView = self.value(forKey: "_view") as! UIView
        for subView in tabBarButton.subviews {
            if subView.isKind(of: NSClassFromString("UITabBarSwappableImageView")!) {
                return subView
            }
        }
        return tabBarButton
    }
}
