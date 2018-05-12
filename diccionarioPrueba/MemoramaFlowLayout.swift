//
//  MemoramaFlowLayout.swift
//  diccionarioPrueba
//
//  Created by Mickey Rocha on 4/25/18.
//  Copyright © 2018 Valeria Rocha Sepulveda . All rights reserved.
//

import UIKit

class MemoramaFlowLayout: UICollectionViewFlowLayout {
    //    //MARK: - External configuration
    //    @IBInspectable var minCellSize: CGSize = CGSize(width: 96, height: 96) {
    //        didSet {
    //            invalidateLayout()  // para que se vuelva a repintar
    //        }
    //    }
    //    @IBInspectable var cellSpacing: CGFloat = 8 {
    //        didSet {
    //            invalidateLayout()
    //        }
    //    }
    
    //MARK: - Internal Metrics
    
    private var cellCount: Int {
        return collectionView!.dataSource!.collectionView(collectionView!, numberOfItemsInSection: 0)
    }
    
    private var contentSize: CGSize = CGSize.zero
    private var columns: Int = 4
    private var rows: Int = 3
    var cellSpacing: CGFloat = 15
    private var cellSize: CGSize = CGSize.zero
    private var cellCenterPoints: [CGPoint] = []
    
    
    //MARK: - Layout Overrides
    
    override func prepare() {
        let collectionViewWidth = collectionView!.frame.size.width
        let collectionViewHeight = collectionView!.frame.size.height
        
        // Calculate the number of rows and columns
        //        columns = Int( (collectionViewWidth - cellSpacing) / (minCellSize.width + cellSpacing) )
        //        rows = Int ( ceil(Double(cellCount) / Double(columns)) )
        //let itemSize = (cvMemorama.frame.size.width - 15) / 6 - 15
        let minCellSize: CGSize = CGSize(width: (collectionViewWidth - 15) / CGFloat(columns) - 15, height: (collectionViewHeight - 15) / CGFloat(rows) /*row*/ - 15)
        
        // take the remainder gap and divide it among the existing columns
        let innerWidth = (CGFloat(columns) * (minCellSize.width + cellSpacing)) + cellSpacing
        let extraWidth = collectionViewWidth - innerWidth
        let cellGrowth = extraWidth / CGFloat(columns)
        cellSize.width = floor(minCellSize.width + cellGrowth)
        let innerHeight = (CGFloat(rows) * (minCellSize.height + cellSpacing)) + cellSpacing
        let extraHeight = collectionViewHeight - innerHeight
        let cellHeight = extraHeight / CGFloat(rows)
        cellSize.height = floor(minCellSize.height + cellHeight)
        
        // For each cell, calculate and store its center points
        for itemIndex in 0..<cellCount {
            // locate the cell's position in the grid
            let coordBreakdown = modf(CGFloat(itemIndex) / CGFloat(columns))
            let row = Int (coordBreakdown.0) + 1
            let col = Int (round(coordBreakdown.1 * CGFloat(columns))) + 1
            
            // calculate the actual centerpoint of the cel, given its position
            var cellBottomRight = CGPoint()
            cellBottomRight.x = CGFloat(col) * (cellSpacing + cellSize.width)
            cellBottomRight.y = CGFloat(row) * (cellSpacing + cellSize.height)
            
            var cellCenter = CGPoint()
            cellCenter.x = cellBottomRight.x - (cellSize.width / 2.0)
            cellCenter.y = cellBottomRight.y - (cellSize.height / 2.0)
            
            cellCenterPoints.append(cellCenter)
        }
        
    }
    
    // calculate the total content size of the collection
    override var collectionViewContentSize: CGSize {
        let contentWidth = (cellSize.width + cellSpacing) * CGFloat(columns) + cellSpacing
        let contentHeight = (cellSize.height + cellSpacing) * CGFloat(rows) + cellSpacing
        let contentSize = CGSize(width: contentWidth, height: contentHeight)
        return contentSize
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var allAttributes: [UICollectionViewLayoutAttributes] = []
        
        for itemIndex in 0..<cellCount {
            if rect.contains(cellCenterPoints[itemIndex]) {
                let indexPath = IndexPath(item: itemIndex, section: 0)
                let attributes = layoutAttributesForItem(at: indexPath)!
                allAttributes.append(attributes)
            }
        }
        return allAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = super.layoutAttributesForItem(at: indexPath) else {
            return nil
        }
        attributes.size = cellSize
        attributes.center = cellCenterPoints[indexPath.row]
        
        return attributes
    }
    
}

