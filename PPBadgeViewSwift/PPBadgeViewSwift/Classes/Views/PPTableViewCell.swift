//
//  PPTableViewCell.swift
//  PPBadgeViewSwift
//
//  Created by AndyPang on 2017/6/19.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

import UIKit

class PPTableViewCell: UITableViewCell {

    @IBOutlet weak var headerView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.headerView.layer.cornerRadius = 3
        self.setupBadge()
    }

    func setupBadge() {
        
        // 1. 给headeView添加小圆点
        self.headerView.pp.addDot(color: randomColor())
        self.headerView.pp.moveBadge(x: -1, y: 1)
    }
    
    
    /// 获取随机颜色
    func randomColor() -> UIColor {
        let randomRed = CGFloat(arc4random()%255)/255.0
        let randomGreen = CGFloat(arc4random()%255)/255.0
        let randomBlue = CGFloat(arc4random()%255)/255.0
        return UIColor.init(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
}
