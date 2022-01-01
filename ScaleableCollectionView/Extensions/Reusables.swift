//
//  Reusable.swift
//  ScaleableCollectionView
//
//  Created by Heiko von Wegerer on 29.12.21.
//

import UIKit

public protocol Reusable {}

// MARK: - UICollectionViewCell

extension LabelCollectionViewCell: Reusable {}

extension Reusable where Self: UICollectionViewCell {
    
    static var nib: UINib {
        return UINib(nibName: self.reuseIdentifier, bundle: Bundle(for: self))
    }
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
}
