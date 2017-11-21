//
//  RQGridImages.swift
//  RQGridImagesDemo
//
//  Created by 阮琦 on 2017/10/26.
//  Copyright © 2017年 Q.Roy. All rights reserved.
//

protocol RQGridImagesDelegate {
    func gridImages(_ gridImages: RQGridImages, updatedFrame frame: CGRect)
    func gridImages(_ gridImages: RQGridImages, didSelectItemAt indexPath: IndexPath)
    func gridImages(_ gridImages: RQGridImages, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
}

extension RQGridImagesDelegate {
    func gridImages(_ gridImages: RQGridImages, updatedFrame frame: CGRect) {}
    func gridImages(_ gridImages: RQGridImages, didSelectItemAt indexPath: IndexPath) {}
    func gridImages(_ gridImages: RQGridImages, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return RQDefaultGridCollectionViewCell.defaultCell(gridImages, cellForItemAt: indexPath)
    }
}

import UIKit

class RQGridImages: UICollectionView {
    /// gridImages's item data source, type can be UIImage, URL, URLString
    var images: [Any] = [] {
        didSet {
            self.updateDataSource()
        }
    }
    
    /// gridImages's column number, default is 3;
    var column: Int = 3
    
    /// gridImages's item's max visable number, default is 9;
    var maxItemCount: Int = 9
    
    private var layout = UICollectionViewFlowLayout.init()
    
    /// gridImages's item's row spacing, default is 10;
    var rowSpacing: CGFloat = 10 {
        didSet {
            self.layout.minimumLineSpacing = rowSpacing
        }
    }
    
    /// gridImages's item's column spacing, default is 10;
    var columnSpacing: CGFloat = 10 {
        didSet {
            self.layout.minimumInteritemSpacing = columnSpacing
        }
    }
    
    /// gridImages's item's specified size, default is nil; if value is not equal to nil, grid view will not calculate item size by property itemCountInLine;
    var specifiedItemSize: CGSize? {
        didSet {
            self.layout.itemSize = self.realtimeItemSize()
        }
    }
    
    /// gridImages's item's specified height, default is nil; if value is not equal to nil, grid view will calculate item size by property itemCountInLine and specifiedItemHeight
    var specifiedItemHeight: CGFloat? {
        didSet {
            self.layout.itemSize = self.realtimeItemSize()
        }
    }
   
    /// gridImages's delegate
    var gridImagesDelegate: RQGridImagesDelegate?
    
    /// gridImages's item configuration closure, default is nil, if use this closure delegate method 'gridImages(_ gridImages: RQGridImages, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell' will not be preformed
    var gridImagesItem: ((_ gridImages: RQGridImages, _ indexPath: IndexPath) -> UICollectionViewCell)?
    
    /// gridImages's item did selected handler closure, default is nil, , if use this closure delegate method 'gridImages(_ gridImages: RQGridImages, didSelectItemAt indexPath: IndexPath)' will not be preformed
    var gridImagesDidSelectHandler: ((_ gridImages: RQGridImages, _ indexPath: IndexPath) -> ())?
    

    /// is enable show log, default is true
    var showLog: Bool = true
    
    private let screenWidth = UIScreen.main.bounds.size.width
    private let screenHeight = UIScreen.main.bounds.size.height
    
    
    //MARK: Initialize Part
    
    
    /// initialize with flow layout and frame
    ///
    /// - Parameter frame: gridImages's frame
    required convenience init(frame: CGRect) {
        self.init(frame: frame, collectionViewLayout: UICollectionViewLayout())
    }
    
    /// initialize with system method
    ///
    /// - Parameters:
    ///   - frame: gridImages's frame
    ///   - layout: UICollectionViewLayout style for grid view, what ever value input, set with self.layout
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: self.layout)
        self.delegate = self
        self.dataSource = self
        
        self.contentSize = CGSize.zero
        self.backgroundColor = UIColor.white
        self.isScrollEnabled = false
        
        
        self.register(RQDefaultGridCollectionViewCell.self, forCellWithReuseIdentifier: RQDefaultGridCollectionViewCell.reuseId)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    //MARK: Layout Part
    override func layoutSubviews() {
        self.updateFrameIfNeeded()
        super.layoutSubviews()
        // update frame when using auto layout
    }
    
    private func updateFrameIfNeeded() {
        guard self.frame.width > 0 else {
            return
        }
        
        let height = self.realTimeHeight()
        guard height > 0, height != self.frame.height else {
            return
        }
        let newFrame = CGRect.init(origin: self.frame.origin, size: CGSize(width: self.frame.width, height: height))
        self.updateFrame(newFrame)
    }
    
    private func updateFrame(_ newFrame: CGRect) {
        self.frame = newFrame
        
        if let delegate = self.gridImagesDelegate {
            delegate.gridImages(self, updatedFrame: newFrame)
        }
        self.reloadData()
    }
    
    
    
    
    //MARK: data source Part
    
    private func updateDataSource() {
        guard self.images.count <= self.maxItemCount else {
            var tmpStack = [Any]()
            for i in 0..<self.maxItemCount {
                tmpStack.append(self.images[i])
            }
            self.images = tmpStack
            return
        }
        self.updateFrameIfNeeded()
    }
}



//MARK: extension for realtime frame calculation

extension RQGridImages {
    private func realtimeItemSize() -> CGSize {
        if let size = self.specifiedItemSize {
            if showLog {
                print("RQGridImages use specified item size, item size is: \(String(describing: self.specifiedItemSize!))")
            }
            self.layout.itemSize = size
            return size
        }
        
        let gridWidth = self.frame.width
        let totalColumnSpacing = CGFloat.init(column - 1) * self.columnSpacing
        let itemWidth = (gridWidth - totalColumnSpacing) / CGFloat.init(column)
        
        if let specifiedItemHeight = self.specifiedItemHeight {
            let size = CGSize.init(width: itemWidth, height: specifiedItemHeight)
            if showLog {
                print("RQGridImages use specified item height, item size is: \(String(describing: size))")
            }
            self.layout.itemSize = size
            return size
        } else {
            let size = CGSize.init(width: itemWidth, height: itemWidth)
            if showLog {
                print("RQGridImages use calculated item size, item size is: \(String(describing: size))")
            }
            self.layout.itemSize = size
            return size
        }
    }
    
    private func realtimeLineCount() -> Int {
        let itemCount = Double.init(self.images.count)
        let column = Double.init(self.column)
        let lineCount = Int(ceil(itemCount / column))
        
        if showLog {
            print("RQGridImages use calculated line count, lines count is: \(String(lineCount))")
        }
        return lineCount
    }
    
    private func realTimeHeight() -> CGFloat {
        let lineCount = CGFloat(self.realtimeLineCount())
        let itemHeight = self.realtimeItemSize().height
        guard lineCount > 0 && itemHeight > 0 else {
            if showLog {
                print("RQGridImages use calculated height, height is: 0)")
            }
            return 0
        }
        
        let totalRowSpacing = self.rowSpacing * (lineCount - 1)
        let totalItemsHeight = lineCount * itemHeight
        let gridImagesHeight = totalRowSpacing + totalItemsHeight
        
        if showLog {
            print("RQGridImages use calculated height, height is: \(gridImagesHeight)")
        }
        return gridImagesHeight
    }
}


//MARK: extension for gridImages data source and delegate

extension RQGridImages: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let gridImagesItem = self.gridImagesItem?(collectionView as! RQGridImages, indexPath) {
            return gridImagesItem
        }
        if let delegate = self.gridImagesDelegate {
            return delegate.gridImages(collectionView as! RQGridImages, cellForItemAt: indexPath)
        } else {
            return RQDefaultGridCollectionViewCell.defaultCell(collectionView, cellForItemAt: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let handler = self.gridImagesDidSelectHandler {
            handler(collectionView as! RQGridImages, indexPath)
            
        }
        if let delegate = self.gridImagesDelegate {
            delegate.gridImages(collectionView as! RQGridImages, didSelectItemAt: indexPath)
        }
    }
    
        func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            if cell is RQDefaultGridCollectionViewCell {
                let defaultCell = cell as! RQDefaultGridCollectionViewCell
                defaultCell.imageView.setImage(withImageResource: self.images[indexPath.row], errorReplaceImage: UIImage(), errorHandler: nil)
            }
        }

}

class RQDefaultGridCollectionViewCell: UICollectionViewCell {
    static let reuseId = "RQDefaultGridCollectionViewCellReuseId"
    
    var imageView: UIImageView
    var titleLabel: UILabel

    override init(frame: CGRect) {
        self.imageView = UIImageView.init(frame: CGRect.init(origin: CGPoint.zero, size: frame.size))
        self.titleLabel = UILabel.init(frame: CGRect.init(origin: CGPoint.zero, size: frame.size))
        super.init(frame: frame)

        self.contentView.addSubview(imageView)
        self.contentView.addSubview(titleLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func defaultCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RQDefaultGridCollectionViewCell.reuseId, for: indexPath) as? RQDefaultGridCollectionViewCell else {
            return RQDefaultGridCollectionViewCell()
        }
        cell.tag = indexPath.row
        cell.titleLabel.text = "\(cell.tag)"
        return cell
    }
}

