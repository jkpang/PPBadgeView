//
//  PPBadgeLabel.swift
//  PPBadgeViewSwift
//
//  Created by AndyPang on 2017/6/19.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

import UIKit

class PPBadgeLabel: UILabel {
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupUI();
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    public class func defaultBadgeLabel() -> PPBadgeLabel {
        return PPBadgeLabel.init(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
    }
    
    func setupUI() {
        self.textColor = UIColor.white
        self.font = UIFont.systemFont(ofSize: 13)
        self.textAlignment = NSTextAlignment.center
        self.layer.cornerRadius = self.p_height * 0.5
    }
}
