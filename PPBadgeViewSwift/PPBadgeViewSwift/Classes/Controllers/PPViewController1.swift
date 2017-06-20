//
//  PPViewController1.swift
//  PPBadgeViewSwift
//
//  Created by AndyPang on 2017/6/19.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

import UIKit

class PPViewController1: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        
        setupBadges()
    }

    func setupBadges() {
        
        // 1.给UIBarButtonItem添加badge
        // 1.1 左边
        self.navigationItem.leftBarButtonItem?.pp_addBadge(number: 1);
        // 调整badge大小
        self.navigationItem.leftBarButtonItem?.pp_setBadgeHeight(points: 21.0);
        // 调整badge的位置
        self.navigationItem.leftBarButtonItem?.pp_moveBadge(x: -7, y: 5)
        // 自定义badge的属性: 字体大小/颜色, 背景颜色...(默认系统字体13,白色,背景色为系统badge红色)
        self.navigationItem.leftBarButtonItem?.pp_setBadgeLabel(attributes: { (badgeLabel) in
            // badgeLabel.font = UIFont.systemFont(ofSize: 13)
            // badgeLabel.textColor = UIColor.blue
        })
        
        // 1.2 右边
        self.navigationItem.rightBarButtonItem?.pp_addDot(color: nil);
        self.navigationItem.rightBarButtonItem?.pp_moveBadge(x: -5, y: 0);
    }
    
    func setupViews() {
        self.tableView.rowHeight = 60
        self.tableView.register(UINib.init(nibName: "PPTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .trash, target: self, action: Selector("delete"))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: Selector("add"))
    }
    
    func delete() {
        self.navigationItem.leftBarButtonItem?.pp_decrease()
    }
    func add() {
        self.navigationItem.leftBarButtonItem?.pp_increase()
    }
    
}

extension PPViewController1: UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return tableView.dequeueReusableCell(withIdentifier: "cell")!
    }
}
