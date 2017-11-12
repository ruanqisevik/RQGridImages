//
//  RQGridView.swift
//  RQGridImagesDemo
//
//  Created by 阮琦 on 2017/10/26.
//  Copyright © 2017年 Q.Roy. All rights reserved.
//


protocol GridViewFrameUpdateProtocol {
    func frameDidUpdated(_ frame: CGRect)
}

extension GridViewFrameUpdateProtocol {
    func frameDidUpdated(_ frame: CGRect) {
    }
}

import UIKit
import SnapKit

class RQGridView: UICollectionView {
    /// grid item data source, type can be UIImage, URL
    var images: [Any] = [] {
        didSet {
            self.updateDataSource()
        }
    }
    
    /// grid item count in line, default is 3;
    var itemCountInLine: Int = 3
    
    /// grid item's spacing, default is 10;
    var itemSpacing: CGFloat = 10
    
    /// grid item's max visable count, default is 9;
    var maxItemCount: Int = 9
    
    /// grid view's scroll direction, default is vertical
    var scrollDirection: UICollectionViewScrollDirection = .vertical
    
    var showLog: Bool = true
    
    var frameUpdateDelegate: GridViewFrameUpdateProtocol?
    
    private let screenWidth = UIScreen.main.bounds.size.width
    private let screenHeight = UIScreen.main.bounds.size.height
    
    private let gridItemReuseId = "gridItemReuseId"
    
    private var currentItemSize: CGSize? {
        didSet {
            guard let layout = self.collectionViewLayout as? UICollectionViewFlowLayout, let itemSize = currentItemSize else {
                return
            }
            layout.itemSize = itemSize
        }
    }
    private var currentGridWidth: CGFloat = 0
    
    /// initialize with system method
    ///
    /// - Parameters:
    ///   - frame: grid view's frame
    ///   - layout: UICollectionViewLayout style for grid view
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.register(RQGridCell.self, forCellWithReuseIdentifier: gridItemReuseId)
        self.setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// initialize with flow layout and frame
    ///
    /// - Parameter frame: grid view's frame
    required convenience init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout.init()
        self.init(frame: frame, collectionViewLayout: layout)
        self.setup(collectionViewFlowLayout: self.collectionViewLayout as! UICollectionViewFlowLayout)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        // update frame when using auto layout
        self.updateFrameIfNeeded()
    }
    
    private func setupCollectionView() {
        self.delegate = self
        self.dataSource = self
        
        self.contentSize = self.frame.size
        self.backgroundColor = UIColor.white
    }
    
    private func setup(collectionViewFlowLayout layout: UICollectionViewFlowLayout) {
        layout.itemSize = self.realTimeItemSize()
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
    }
    
    private func updateDataSource() {
        guard self.images.count <= self.maxItemCount else {
            var tmpStack = [Any]()
            for i in 0..<self.maxItemCount {
                tmpStack.append(self.images[i])
            }
            self.images = tmpStack
            return
        }
//        if self.images.count <= 0 {
//
//        } else {
//            if self.images.first! is UIImage {
//
//            } else if self.images.first! is URL {
//
//            }
//        }
        self.updateFrameIfNeeded()
    }
    
    private func updateFrameIfNeeded() {
        guard self.frame.width != self.currentGridWidth else {
            return
        }
        self.currentGridWidth = self.frame.width

        let height = self.realTimeHeight()
        guard height > 0, height != self.frame.height else {
            return
        }
        let newFrame = CGRect.init(origin: self.frame.origin, size: CGSize(width: self.frame.width, height: height))
        self.updateFrame(newFrame)
    }
    
    private func updateFrame(_ newFrame: CGRect) {
        self.frame = newFrame
        if let delegate = self.frameUpdateDelegate {
            delegate.frameDidUpdated(newFrame)
        }
    }
    
    private func realTimeItemSize() -> CGSize {
        let itemLength = (self.currentGridWidth - CGFloat(itemCountInLine - 1) * self.itemSpacing) / CGFloat(itemCountInLine)
        self.currentItemSize = CGSize.init(width: itemLength, height: itemLength)
        
        if showLog {
            print("real time item size is ......\(String(describing: self.currentItemSize))")
        }
        return self.currentItemSize!
    }
    
    private func realTimeLineCount() -> Int {
        let itemCount = self.images.count
        let itemCountInLine = self.itemCountInLine
        let lineCount = Int(ceil(Double(itemCount / itemCountInLine)))
        
        if showLog {
            print("real time line count is ......\(lineCount)")
        }
        return lineCount
    }
    
    private func realTimeHeight() -> CGFloat {
        let lineCount = CGFloat(self.realTimeLineCount())
        guard lineCount > 0 else {
            return 0
        }
        let lineSpacing = (self.collectionViewLayout as! UICollectionViewFlowLayout).minimumLineSpacing
        let height = lineSpacing * (lineCount - 1) + lineCount * self.realTimeItemSize().height
        
        if showLog {
            print("real time height is ......\(height)")
        }
        return height
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension RQGridView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gridItemReuseId, for: indexPath) as? RQGridCell else {
            return RQGridCell()
        }
        cell.backgroundColor = UIColor.red
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension RQGridView: UICollectionViewDelegate {
    
}

class RQGridImageView: UIImageView {
    
}
