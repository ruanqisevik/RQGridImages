//
//  TableViewController.swift
//  RQGridImagesDemo
//
//  Created by 阮琦 on 2017/10/26.
//  Copyright © 2017年 Q.Roy. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {

    let arr = []
    
    let cellId = "resuseId"
    var list: UITableView = UITableView.init(frame: CGRect.init(origin: CGPoint.zero, size: UIScreen.main.bounds.size), style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(list)
        
        self.list.delegate = self
        self.list.dataSource = self
        
        self.list.register(RQGridTableViewCell.self, forCellReuseIdentifier: cellId)
        self.list.estimatedRowHeight = 100
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

}

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension TableViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! RQGridTableViewCell
        cell.grid.images = arr[indexPath.row]
        cell.cellUpdateDelegate = self
        // Configure the cell...
        
        return cell
    }
}

extension TableViewController: RQGridTableViewCellUpdateDelegate {
    func gridCellDidUpdated() {
        self.list.reloadData()
    }
}
