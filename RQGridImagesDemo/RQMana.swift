//
//  RQMana.swift
//  RQGridImagesDemo
//
//  Created by 阮琦 on 2017/10/27.
//  Copyright © 2017年 Q.Roy. All rights reserved.
//

import UIKit

import SDWebImage

extension UIImageView {
    func setImage(withImageResource imageResource: Any?, errorReplaceImage: UIImage?, errorHandler: ((UIImageView) -> ())?) {
        guard let imageResource = imageResource else {
            if let errorReplaceImage = errorReplaceImage {
                self.image = errorReplaceImage
                errorHandler?(self)
            }
            return
        }
        if imageResource is UIImage {
            let resource = imageResource as! UIImage
            self.image = resource
        } else if imageResource is Data {
            let resource = imageResource as! Data
            self.image = UIImage.init(data: resource)
        } else if imageResource is URL {
            let resource = imageResource as! URL
            self.sd_setImage(with: resource, completed: nil)
        } else if imageResource is String {
            let resource = imageResource as! String
            guard let url = URL.init(string: resource) else {
                self.image = errorReplaceImage
                errorHandler?(self)
                return
            }
            self.sd_setImage(with: url, completed: nil)
        } else {
            self.image = errorReplaceImage
            errorHandler?(self)
        }
    }
}

