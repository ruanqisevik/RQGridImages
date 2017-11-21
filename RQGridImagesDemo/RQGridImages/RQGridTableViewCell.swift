//
//  RQGridTableViewCell.swift
//  RQGridImagesDemo
//
//  Created by 阮琦 on 2017/11/6.
//  Copyright © 2017年 Q.Roy. All rights reserved.
//

protocol RQGridTableViewCellUpdateDelegate {
    func gridCellDidUpdated()
}

import UIKit
import SnapKit

class RQGridTableViewCell: UITableViewCell {
    var cellUpdateDelegate: RQGridTableViewCellUpdateDelegate?
    var grid: RQGridView = RQGridView.init(frame: CGRect.zero)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(grid)
        self.grid.frameUpdateDelegate = self
        self.grid.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(5)
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

extension RQGridTableViewCell: GridViewFrameUpdateProtocol {
    func frameDidUpdated(_ frame: CGRect) {
        self.grid.snp.updateConstraints { (make) in
            make.height.equalTo(frame.height)
        }
        if let delegate = self.cellUpdateDelegate {
            delegate.gridCellDidUpdated()
        }
    }
}
