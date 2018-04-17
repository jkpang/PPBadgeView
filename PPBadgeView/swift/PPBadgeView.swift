//
//  PPBadgeView.swift
//  PPBadgeViewSwift
//
//  Created by jkpang on 2018/4/17.
//  Copyright © 2018年 AndyPang. All rights reserved.
//

import UIKit

public struct PP<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public extension NSObjectProtocol {
    public var pp: PP<Self> {
        return PP(self)
    }
}

public enum PPBadgeViewFlexMode {
    case head    // 左伸缩 Head Flex    : <==●
    case tail    // 右伸缩 Tail Flex    : ●==>
    case middle  // 左右伸缩 Middle Flex : <=●=>
}
