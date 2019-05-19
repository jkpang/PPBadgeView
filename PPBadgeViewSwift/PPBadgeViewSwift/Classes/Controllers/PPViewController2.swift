//
//  PPViewController2.swift
//  PPBadgeViewSwift
//
//  Created by AndyPang on 2017/6/19.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

import UIKit

class PPViewController2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        let testView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        testView.backgroundColor = UIColor.blue
        testView.pp.addBadge(number: 10)
        view.addSubview(testView)
        
        let testView2 = UIView(frame: CGRect(x: 100, y: 250, width: 100, height: 100))
        testView2.backgroundColor = UIColor.blue
        testView2.pp.badgeView.textLabel.text = "哈哈"
        testView2.pp.badgeView.textLabel.font = UIFont.systemFont(ofSize: 10)
        testView2.pp.setBadge(height: 15)
        view.addSubview(testView2)
        
        let testView3 = UIView(frame: CGRect(x: 100, y: 400, width: 100, height: 100))
        testView3.backgroundColor = UIColor.blue
        let attStr = NSAttributedString.init(string: "hello")
        testView3.pp.badgeView.textLabel.attributedText = attStr
        view.addSubview(testView3)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
