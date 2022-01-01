//
//  GridCalculatorTests+10Grid.swift
//  KachelTests
//
//  Created by Heiko von Wegerer on 19.12.21.
//

import XCTest
@testable import ScaleableCollectionView

class ScaleableArrayTests_10Grid: XCTestCase {

    var scaleableArray = ScaleableArray()
    
    private func customGrid(selectedIndex: Int) {
        let value = 1.0 / 10.0
        scaleableArray.values = [CGFloat](repeating: value, count: 10)
        scaleableArray.minValue = 0.05
        scaleableArray.selectedIndex = selectedIndex
    }

}

extension ScaleableArrayTests_10Grid {
    
    func testSum_shouldBeOne() {
        customGrid(selectedIndex: 4)
        scaleableArray.calculateNewValues(2.0)
        
        XCTAssertEqual(scaleableArray.scaledValues.sum().roundedValue, "1.00")
    }
    
    func testSum_minValue() {
        customGrid(selectedIndex: 4)
        scaleableArray.calculateNewValues(4.0)
        
        XCTAssertEqual(scaleableArray.scaledValues.min()?.roundedValue, "0.07")
    }
    
    func testValues_resizing() {
        customGrid(selectedIndex: 9)
        scaleableArray.minValue = 0.00
        scaleableArray.calculateNewValues(10)
        scaleableArray.calculateNewValues(0.3)
        
        XCTAssertEqual(scaleableArray.scaledValues.sum().roundedValue, "1.00")
    }
    
}
