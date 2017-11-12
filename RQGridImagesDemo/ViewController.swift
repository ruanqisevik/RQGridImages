//
//  ViewController.swift
//  RQGridImagesDemo
//
//  Created by 阮琦 on 2017/10/26.
//  Copyright © 2017年 Q.Roy. All rights reserved.
//

import UIKit
import SnapKit

/// Single Grid View Example
class ViewController: UIViewController {
    /// GridView
    var gridView = RQGridView()
    
    private var showTableGridButton: UIButton = UIButton.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.gridView = RQGridView.init(frame: CGRect.init(origin: CGPoint.init(x: 37.5, y: 20), size: CGSize.init(width: 300, height: 100)))
        self.view.addSubview(self.gridView)
    
        self.showTableGridButton.setTitle("jump to table grid", for: .normal)
        self.showTableGridButton.backgroundColor = UIColor.darkGray
        self.showTableGridButton.addTarget(self, action: #selector(self.clickToTableGrid), for: .touchUpInside)
        self.view.addSubview(showTableGridButton)

        self.gridView.images = [
            "http://www.baidu.com",
            "http://www.baidu.com",
            "http://www.baidu.com",
            "http://www.baidu.com",
            "http://www.baidu.com",
            "http://www.baidu.com",
            "http://www.baidu.com",
            "http://www.baidu.com",
            "http://www.baidu.com",
            "http://www.baidu.com",
            "http://www.baidu.com",
            "http://www.baidu.com",
        ]
        
        self.setupGridView()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func setupGridView() {
//        self.gridView.snp.makeConstraints { (make) in
//            make.top.equalToSuperview()
//        }
        self.showTableGridButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.gridView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc private func clickToTableGrid() {
        self.present(TableViewController(), animated: true, completion: nil)
    }

}

