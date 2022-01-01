//
//  GridCalculatorTests+EdgeCases.swift
//  KachelTests
//
//  Created by Heiko von Wegerer on 19.12.21.
//

import XCTest
@testable import ScaleableCollectionView

class ScaleableArrayTests_EdgeCases: XCTestCase {
    
    var scaleableArray = ScaleableArray()
    
}

// MARK: - Test selected index max

extension ScaleableArrayTests_EdgeCases {
    
    func testEmptyArray_selectedIndex_max() throws {
        scaleableArray.selectedIndex = Int.max
        scaleableArray.calculateNewValues(0)
        
        XCTAssertTrue(scaleableArray.scaledValues.isEmpty)
    }
    
    func testFilledArray_selectedIndex_max() throws {
        let values: [CGFloat] = [0.3, 0.2, 0.5]
        scaleableArray.selectedIndex = Int.max
        scaleableArray.values = values
        scaleableArray.calculateNewValues(0)

        XCTAssertEqual(scaleableArray.scaledValues, values)
    }
    
}

// MARK: - Tests Empty Array

extension ScaleableArrayTests_EdgeCases {

    func testEmptyValues_withZeroFactor() throws {
        scaleableArray.calculateNewValues(0)
        
        XCTAssertTrue(scaleableArray.scaledValues.isEmpty)
    }

    func testEmptyValues_negativeGreatestFactor() throws {
        scaleableArray.calculateNewValues(-Double.greatestFiniteMagnitude)

        XCTAssertTrue(scaleableArray.scaledValues.isEmpty)
    }

    func testEmptyValues_greatestFactor() throws {
        scaleableArray.calculateNewValues(Double.greatestFiniteMagnitude)

        XCTAssertTrue(scaleableArray.scaledValues.isEmpty)
    }

}
