//
//  ScaleableCollectionView.swift
//  ScaleableCollectionView
//
//  Created by Heiko von Wegerer on 23.12.21.
//

import UIKit

class ScaleableCollectionView: UICollectionView {

    // MARK: - Public vars
    
    var config: ScalableCollectionViewConfig? {
        didSet {
            if let config = config {
                viewLayout.config = config
                self.collectionViewLayout.invalidateLayout()
            }
        }
    }
    
    // MARK: - Private vars
    
    private var viewLayout = ScaleableGridCollectionViewLayout()
    
    // MARK: - Life cycle
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        self.isScrollEnabled = false
        self.isUserInteractionEnabled = true
        self.collectionViewLayout = viewLayout
        
        // Pin Gesture Recognizer
        let pinchGesture = UIPinchGestureRecognizer(target: viewLayout, action: #selector(viewLayout.handleScreenEdgePan))
        self.addGestureRecognizer(pinchGesture)
    }

}
