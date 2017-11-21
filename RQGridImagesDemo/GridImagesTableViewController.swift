//
//  GridImagesTableViewController.swift
//  TestImagePicker
//
//  Created by 阮琦 on 2017/11/20.
//  Copyright © 2017年 Q.Roy. All rights reserved.
//

import UIKit
import SnapKit

class GridImagesTableViewController: UIViewController {
    var list: UITableView = UITableView.init(frame: CGRect.zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(list)
        list.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }

        self.list.delegate = self
        self.list.dataSource = self
        
        self.list.estimatedRowHeight = 100
        self.list.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension GridImagesTableViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource().count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource()[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseId = "RQDefaultGridImagesCell_\(indexPath.section)_\(indexPath.row)"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseId) as? RQDefaultGridImagesTableViewCell
        if cell == nil {
            cell = RQDefaultGridImagesTableViewCell.init(style: .default, reuseIdentifier: reuseId)
        }
        cell?.gridImages.images = dataSource()[indexPath.section][indexPath.row]
        cell?.delegate = self
        return cell!
    }
}

extension GridImagesTableViewController {
    func dataSource() -> [[[String]]] {
        return [
            [
                [
                    "http://oi39.tinypic.com/2wd0ojl.jpg",
                    "http://oi43.tinypic.com/14ida8p.jpg",
                    "http://s8.tinypic.com/28je8le.jpg",
                    "http://oi43.tinypic.com/14ida8p.jpg",
                    "http://oi39.tinypic.com/2wd0ojl.jpg",
                    "http://s8.tinypic.com/28je8le.jpg",
                    "http://s8.tinypic.com/28je8le.jpg",
                    "http://oi43.tinypic.com/14ida8p.jpg"
                ],
                [
                    "http://oi39.tinypic.com/2wd0ojl.jpg",
                    "http://s8.tinypic.com/28je8le.jpg",
                    "http://s8.tinypic.com/28je8le.jpg",
                    "http://oi43.tinypic.com/14ida8p.jpg"
                ],
                [
                    "http://oi39.tinypic.com/2wd0ojl.jpg",
                    "http://s8.tinypic.com/28je8le.jpg",
                    "http://s8.tinypic.com/28je8le.jpg",
                    "http://oi43.tinypic.com/14ida8p.jpg",
                    "http://oi39.tinypic.com/2wd0ojl.jpg",
                    "http://s8.tinypic.com/28je8le.jpg",
                    "http://s8.tinypic.com/28je8le.jpg",
                    "http://oi43.tinypic.com/14ida8p.jpg"
                ],
                [
                    "http://s8.tinypic.com/28je8le.jpg",
                    "http://oi43.tinypic.com/14ida8p.jpg"
                ]
            ],
            [
                [
                    "http://s8.tinypic.com/28je8le.jpg",
                    "http://oi43.tinypic.com/14ida8p.jpg",
                    "http://s8.tinypic.com/28je8le.jpg",
                    "http://oi43.tinypic.com/14ida8p.jpg"
                ],
                [
                    "http://s8.tinypic.com/28je8le.jpg"
                ]
            ],
            [
                [
                    "http://s8.tinypic.com/28je8le.jpg",
                    "http://oi43.tinypic.com/14ida8p.jpg"
                ],
                [],
                [
                    "http://s8.tinypic.com/28je8le.jpg",
                    "http://oi43.tinypic.com/14ida8p.jpg",
                    "http://s8.tinypic.com/28je8le.jpg",
                    "http://oi43.tinypic.com/14ida8p.jpg",
                    "http://s8.tinypic.com/28je8le.jpg",
                    "http://oi43.tinypic.com/14ida8p.jpg"
                ]
            ],
        ]
    }
}

extension GridImagesTableViewController: RQDefaultGridImagesTableViewCellDelegate {
    func gridImagesTableViewCellDidSelectGridItem(_cell: RQDefaultGridImagesTableViewCell, cellGridImages gridImages: RQGridImages, didSelectItemAt indexPath: IndexPath) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func gridImagesTableViewCellFrameUpdated(_ cell: RQDefaultGridImagesTableViewCell) {
        self.list.reloadData()
    }
}
