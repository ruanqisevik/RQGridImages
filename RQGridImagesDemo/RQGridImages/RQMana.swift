//
//  RQMana.swift
//  RQGridImagesDemo
//
//  Created by 阮琦 on 2017/10/27.
//  Copyright © 2017年 Q.Roy. All rights reserved.
//

import UIKit

extension UIColor {
    class func random() -> UIColor {
        let red = CGFloat(arc4random_uniform(255))
        let green = CGFloat(arc4random_uniform(255))
        let blue = CGFloat(arc4random_uniform(255))
        return UIColor.init(red: red, green: green, blue: blue, alpha: 1)
    }
}
