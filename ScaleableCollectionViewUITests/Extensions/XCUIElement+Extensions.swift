//
//  XCUIElement+Extensions.swift
//  ScaleableCollectionViewTests
//
//  Created by Heiko von Wegerer on 01.01.22.
//

import Foundation
import XCTest

extension XCUIElement {
    
    /// Returns a collection view cell with the identifier "collectionViewCell-$number'.
    func collectionViewCell(_ number: Int) -> XCUIElement {
        XCUIApplication().collectionViews.cells["collectionViewCell-\(number)"]
    }
    
}
