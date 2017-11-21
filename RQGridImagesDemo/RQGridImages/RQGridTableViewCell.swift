//
//  RQGridTableViewCell.swift
//  RQGridImagesDemo
//
//  Created by 阮琦 on 2017/11/6.
//  Copyright © 2017年 Q.Roy. All rights reserved.
//

protocol RQDefaultGridImagesTableViewCellDelegate {
    func gridImagesTableViewCellFrameUpdated(_ cell: RQDefaultGridImagesTableViewCell)
    func gridImagesTableViewCellDidSelectGridItem(_cell: RQDefaultGridImagesTableViewCell, cellGridImages gridImages: RQGridImages, didSelectItemAt indexPath: IndexPath)
}

extension RQDefaultGridImagesTableViewCellDelegate {
    func gridImagesTableViewCellDidSelectGridItem(_cell: RQDefaultGridImagesTableViewCell, cellGridImages gridImages: RQGridImages, didSelectItemAt indexPath: IndexPath) {}
}

import UIKit

class RQDefaultGridImagesTableViewCell: UITableViewCell {
    var delegate: RQDefaultGridImagesTableViewCellDelegate?
    var gridImages: RQGridImages = RQGridImages.init(frame: CGRect.zero)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.gridImages)
        self.gridImages.gridImagesDelegate = self
        
        if #available(iOS 6.0, *) {
            self.gridImages.translatesAutoresizingMaskIntoConstraints = false
            
            let subViews = ["gridImages": self.gridImages]
            let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[gridImages]-0-|", options: NSLayoutFormatOptions.init(rawValue: 0), metrics: nil, views: subViews)
            let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[gridImages]-0-|", options: NSLayoutFormatOptions.init(rawValue: 0), metrics: nil, views: subViews)
            let heightConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:[gridImages(1)]", options: NSLayoutFormatOptions.init(rawValue: 0), metrics: nil, views: subViews)
            
            self.contentView.addConstraints(hConstraints)
            self.contentView.addConstraints(vConstraints)
            self.contentView.addConstraints(heightConstraint)
        } else {
            print("iOS Version is Lower than 6.0, not supported")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

extension RQDefaultGridImagesTableViewCell: RQGridImagesDelegate {
    func gridImages(_ gridImages: RQGridImages, updatedFrame frame: CGRect) {
        if #available(iOS 6.0, *) {
            self.contentView.constraints.forEach({ (constraint) in
                if constraint.firstAttribute == NSLayoutAttribute.height {
                    constraint.constant = frame.height
                }
                self.contentView.updateConstraints()
            })
        } else {
            print("iOS Version is Lower than 6.0, not supported")
        }
        
        if let delegate = self.delegate {
            delegate.gridImagesTableViewCellFrameUpdated(self)
        }
    }
    
    func gridImages(_ gridImages: RQGridImages, didSelectItemAt indexPath: IndexPath) {
        if let delegate = self.delegate {
            delegate.gridImagesTableViewCellDidSelectGridItem(_cell: self, cellGridImages: gridImages, didSelectItemAt: indexPath)
        }
    }
}

