//
//  GridCalculatorTests.swift
//  KachelTests
//
//  Created by Heiko von Wegerer on 18.12.21.
//

import XCTest
@testable import ScaleableCollectionView

class ScaleableArrayTests: XCTestCase {
    
    var scaleableArray = ScaleableArray()
    
    private func tribbleGrid(selectedIndex: Int) {
        let value = 1.0 / 3.0
        scaleableArray.values = [CGFloat](repeating: value, count: 3)
        scaleableArray.minValue = 0.1
        scaleableArray.selectedIndex = selectedIndex
    }
    
}

// MARK: Test tribble Grid - resize middle Element

extension ScaleableArrayTests {

    func testTribble_doubleSize_middleElement() throws {
        tribbleGrid(selectedIndex: 1)
        scaleableArray.calculateNewValues(2.0)
        
        XCTAssertEqual(scaleableArray.scaledValues[0], (1.0 / 3.0) / 2)
        XCTAssertEqual(scaleableArray.scaledValues[1], (1.0 / 3.0) * 2)
        XCTAssertEqual(scaleableArray.scaledValues[2], (1.0 / 3.0) / 2)
    }
    
    func testTribble_maxSize_middleElement() throws {
        tribbleGrid(selectedIndex: 1)
        scaleableArray.calculateNewValues(4.0)
        
        XCTAssertEqual(scaleableArray.scaledValues[0], scaleableArray.minValue)
        XCTAssertEqual(scaleableArray.scaledValues[1], 0.8)
        XCTAssertEqual(scaleableArray.scaledValues[2], scaleableArray.minValue)
    }
    
    func testTribble_minSize_middleElement() throws {
        tribbleGrid(selectedIndex: 1)
        scaleableArray.calculateNewValues(0.1)
        
        XCTAssertEqual(scaleableArray.scaledValues[0].roundedValue, "0.45")
        XCTAssertEqual(scaleableArray.scaledValues[1], scaleableArray.minValue)
        XCTAssertEqual(scaleableArray.scaledValues[2].roundedValue, "0.45")
    }
    
    func testTribble_zeroFactor_middleElement() throws {
        tribbleGrid(selectedIndex: 1)
        scaleableArray.calculateNewValues(0)
        
        XCTAssertEqual(scaleableArray.scaledValues[0].roundedValue, "0.45")
        XCTAssertEqual(scaleableArray.scaledValues[1], scaleableArray.minValue)
        XCTAssertEqual(scaleableArray.scaledValues[2].roundedValue, "0.45")
    }
    
}
