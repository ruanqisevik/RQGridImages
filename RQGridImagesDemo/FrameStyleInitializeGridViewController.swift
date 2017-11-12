//
//  FrameStyleInitializeGridViewController.swift
//  RQGridImagesDemo
//
//  Created by 阮琦 on 2017/11/10.
//  Copyright © 2017年 Q.Roy. All rights reserved.
//

import UIKit

class FrameStyleInitializeGridViewController: UIViewController {

    var gridView: RQGridView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.gridView = RQGridView.init(frame: CGRect.init(x: 0, y: 20, width: UIScreen.main.bounds.size.width, height: 0))
        
        self.gridView!.images = ["", "", "", "", ""]
        
        let autoLayoutStyleGridViewEntryButton = UIButton.init()
        let gridCellStyleTableViewEntryButton = UIButton.init()
        
//        autoLayoutStyleGridViewEntryButton.setTitle("jump to AutoLayout style grid view ", for: .normal)
//        autoLayoutStyleGridViewEntryButton.backgroundColor = UIColor.darkGray
//        autoLayoutStyleGridViewEntryButton.addTarget(self, action: #selector(), for: .touchUpInside)
        self.view.addSubview(autoLayoutStyleGridViewEntryButton)
        // Do any additional setup after loading the view.
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
