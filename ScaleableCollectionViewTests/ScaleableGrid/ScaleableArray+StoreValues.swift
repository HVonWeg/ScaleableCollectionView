//
//  ScaleableArray+StoreValues.swift
//  ScaleableCollectionViewTests
//
//  Created by Heiko von Wegerer on 29.12.21.
//

import XCTest
@testable import ScaleableCollectionView

class ScaleableArray_StoreValues: XCTestCase {
    
    func testStoreValues_emptyValues() {
        let scaleableArray = ScaleableArray()
        scaleableArray.storeValues(0)
        XCTAssertTrue(scaleableArray.values.isEmpty)
    }
    
    func testStoredValues() {
        let scaleableArray = ScaleableArray(minValue: 0)
        let value = 1.0 / 4.0
        scaleableArray.values = [CGFloat](repeating: value, count: 4)
        scaleableArray.calculateNewValues(0.5)
        scaleableArray.storeValues(0.5)
        XCTAssertEqual(scaleableArray.values.sum().roundedValue, "1.00")
        
    }
}
