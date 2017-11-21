//
//  ViewController.swift
//  TestImagePicker
//
//  Created by 阮琦 on 2017/11/13.
//  Copyright © 2017年 Q.Roy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var gridImagesEntryBtn: UIButton = UIButton()
    var gridImagesTableEntryBtn: UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btnArr = [gridImagesEntryBtn, gridImagesTableEntryBtn]
        var index = 0
        btnArr.forEach { (btn) in
            index += 1
            let yForIndex = 80 * index
            let width = UIScreen.main.bounds.size.width - 40
            btn.frame = CGRect.init(x: 20, y: yForIndex, width: Int(width), height: 50)
            btn.backgroundColor = UIColor.groupTableViewBackground
            btn.setTitleColor(UIColor.black, for: .normal)
            self.view.addSubview(btn)
        }
        
        self.gridImagesEntryBtn.setTitle(" 跳转 gridImages View", for: .normal)
        self.gridImagesEntryBtn.addTarget(self, action: #selector(entryGridImages), for: .touchUpInside)
        
        self.gridImagesTableEntryBtn.setTitle(" 跳转 gridImagesTable View", for: .normal)
        self.gridImagesTableEntryBtn.addTarget(self, action: #selector(entryGridImagesTable), for: .touchUpInside)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func entryGridImages() {
        let targetVC = GridImagesViewController()
        self.present(targetVC, animated: true, completion: nil)
    }
    
    @objc func entryGridImagesTable() {
        let targetVC = GridImagesTableViewController()
        self.present(targetVC, animated: true, completion: nil)
    }
}



