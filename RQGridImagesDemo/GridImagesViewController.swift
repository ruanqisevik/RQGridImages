//
//  GridImagesViewController.swift
//  TestImagePicker
//
//  Created by 阮琦 on 2017/11/19.
//  Copyright © 2017年 Q.Roy. All rights reserved.
//

import UIKit

class GridImagesViewController: UIViewController {
    var gridImages: RQGridImages = RQGridImages.init(frame: CGRect.zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.gridImages)
        
        self.gridImages.frame = CGRect.init(x: 0, y: 20, width: 300, height: 600)
        self.gridImages.gridImagesDelegate = self
        self.gridImages.rowSpacing = 30
        self.gridImages.columnSpacing = 10

        self.gridImages.images = [
                            "http://oi39.tinypic.com/2wd0ojl.jpg",
                            "http://oi43.tinypic.com/14ida8p.jpg",
                            "http://s8.tinypic.com/28je8le.jpg",
                            "http://oi43.tinypic.com/14ida8p.jpg",
                            "http://oi39.tinypic.com/2wd0ojl.jpg",
                            "http://s8.tinypic.com/28je8le.jpg",
                            "http://s8.tinypic.com/28je8le.jpg",
                            "http://oi43.tinypic.com/14ida8p.jpg"
                            ]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension GridImagesViewController: RQGridImagesDelegate {
    func frameDidUpdated(_ GridImages: RQGridImages, _ frame: CGRect) {
        self.gridImages.reloadData()
        self.gridImages.layoutIfNeeded()
    }
    
    func gridImages(_ gridImages: RQGridImages, didSelectItemAt indexPath: IndexPath) {
        self.dismiss(animated: true, completion: nil)
    }
}
