//
//  ScaleableGridCollectionViewLayout.swift
//  ScaleableCollectionView
//
//  Created by Heiko von Wegerer on 23.12.21.
//

import UIKit

class GridLayoutAttributes: UICollectionViewLayoutAttributes {
    var index: GridIndex?
}

class ScaleableGridCollectionViewLayout: UICollectionViewLayout {

    // MARK: Public vars
    
    var config = ScalableCollectionViewConfig() {
        didSet {
            self.rowScaleableArray = ScaleableArray(numberOfValues: config.numberOfRows, minValue: config.minScaleValue)
            self.columnScaleableArray = ScaleableArray(numberOfValues: config.numberOfColumns, minValue: config.minScaleValue)
        }
    }

    // MARK: Private vars
    
    private var attributes = [IndexPath: GridLayoutAttributes]()
    
    /// Stored values that contain the multiplier for a row.
    private lazy var rowScaleableArray = ScaleableArray()
    
    /// Stored values that contain the multiplier for a column.
    private lazy var columnScaleableArray = ScaleableArray()
    
    private var collectionViewWidth: CGFloat {
        collectionView?.bounds.width ?? .zero
    }
    
    private var collectionViewHeight: CGFloat {
        collectionView?.bounds.height ?? .zero
    }

    // MARK: - Private functions
    
    private func reset() {
        self.attributes = [:]
    }

    private func prepareCells() {
        attributes.removeAll()
        var cellYPosition: CGFloat = 0
        for column in 0..<config.numberOfRows {
            let cellHeight = rowScaleableArray.scaledValues[column] * collectionViewHeight
            var cellXPosition: CGFloat = 0
            for row in 0..<config.numberOfColumns {
                let index = column * (config.numberOfColumns) + row
                let cellWidth = columnScaleableArray.scaledValues[row] * collectionViewWidth
                
                let indexPath = IndexPath(item: index, section: 0)
                let attributes = GridLayoutAttributes(forCellWith: indexPath)
                attributes.index = GridIndex(row: row, column: column)
                attributes.frame = CGRect(
                    origin: CGPoint(x: cellXPosition, y: cellYPosition),
                    size: CGSize(width: cellWidth, height: cellHeight))
                self.attributes[indexPath] = attributes
                
                cellXPosition += cellWidth
            }
            cellYPosition += cellHeight
        }
    }

    // MARK: - Overrides
    
    override var collectionViewContentSize: CGSize {
        CGSize(width: collectionViewWidth, height: collectionViewHeight)
    }
    
    override func prepare() {
        super.prepare()
        reset()
        prepareCells()
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        attributes.values.filter { $0.frame.intersects(rect) }
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return attributes[indexPath]
    }

    override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        (self.collectionView?.bounds ?? newBounds) != newBounds
    }
    
}

// MARK: - UIGestureRecognizer Handler

extension ScaleableGridCollectionViewLayout {
    
    @objc func handleScreenEdgePan(gestureRecognizer: UIPinchGestureRecognizer) {
        if gestureRecognizer.state == .began {
            gestureRecognizerShouldBegin(location: gestureRecognizer.location(in: self.collectionView))
        } else if gestureRecognizer.state == .changed {
            gestureRecognizerChanged(scale: gestureRecognizer.scale)
        } else if gestureRecognizer.state == .ended {
            storeScaleValues(scale: gestureRecognizer.scale)
        }
    }

    /// Resize begin.
    private func gestureRecognizerShouldBegin(location: CGPoint) {
        // Get selected cell coordinate
        let yPos = rowScaleableArray.getSelectedIndex(maxSize: collectionViewHeight, selectedPos: location.y)
        let xPos = columnScaleableArray.getSelectedIndex(maxSize: collectionViewWidth, selectedPos: location.x)
        rowScaleableArray.selectedIndex = yPos
        columnScaleableArray.selectedIndex = xPos
    }

    /// Resize changed.
    private func gestureRecognizerChanged(scale: CGFloat) {
        rowScaleableArray.calculateNewValues(scale)
        columnScaleableArray.calculateNewValues(scale)
        
        self.invalidateLayout()
    }

    /// Resize ends. Store new values.
    private func storeScaleValues(scale: CGFloat) {
        rowScaleableArray.storeValues(scale)
        columnScaleableArray.storeValues(scale)
    }
}
