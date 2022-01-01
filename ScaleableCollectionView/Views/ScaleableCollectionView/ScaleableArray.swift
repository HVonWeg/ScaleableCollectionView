//
//  GridCalculator.swift
//  Kachel
//
//  Created by Heiko von Wegerer on 18.12.21.
//

import UIKit

class ScaleableArray {
    
    // MARK: - Public vars
    
    var selectedIndex = 0
    var minValue: Double
    var values = [CGFloat]() {
        didSet {
            scaledValues.removeAll()
            indexedValues.removeAll()
            for (index, value) in values.enumerated() {
                indexedValues[index] = value
                scaledValues.append(value)
            }
        }
    }
    
    /// Stores the scaled values dring the scaling.
    var scaledValues = [CGFloat]()
    
    // MARK: - Private vars
    
    private var indexedValues = [Int: CGFloat]() {
        didSet {
            sortedValues = indexedValues.sorted { $0.1 < $1.1 }
        }
    }
    private var sortedValues = [Dictionary<Int, CGFloat>.Element]()
    private var maxSelectedValue: CGFloat {
        let value = 1 - minValue * CGFloat(values.count - 1)
        return value > 0 ? value : minValue
    }
    
    // MARK: - Life cycle
    
    init(numberOfValues: Int = 0, minValue: Double = 0.06) {
        defer {
            self.values = [CGFloat](repeating: 1.0 / CGFloat(numberOfValues), count: numberOfValues)
        }
        self.minValue = minValue
    }
        
    // MARK: - Public methods
    
    func calculateNewValues(_ scale: CGFloat) {
        guard !values.isEmpty, selectedIndex < values.count else {
            return
        }
        // Calculate selected Value
        let selectedValue = values[selectedIndex]
        var newSelectedValue = selectedValue * scale
        if newSelectedValue > maxSelectedValue {
            newSelectedValue = maxSelectedValue
        } else if newSelectedValue < minValue {
            newSelectedValue = minValue
        }
        scaledValues[selectedIndex] = newSelectedValue
        
        // Calculate all other values
        var deductedAmount = newSelectedValue - selectedValue
        var valuesLeft = CGFloat(values.count - 1)
        for element in sortedValues where element.key != selectedIndex {
            let newValue = max(element.value - deductedAmount / valuesLeft, minValue)
            deductedAmount -= element.value - newValue
            scaledValues[element.key] = newValue
            valuesLeft -= 1
        }
    }
    
    /// Stores the current scaled values for the next scaling.
    func storeValues(_ scale: CGFloat) {
        values = scaledValues
    }
    
    func getSelectedIndex(maxSize: CGFloat, selectedPos: CGFloat) -> Int {
        var currentSize = 0.0
        var pos = 0
        for value in self.values {
            currentSize += maxSize * value
            if selectedPos < currentSize {
                break
            }
            pos += 1
        }
        return pos
    }
    
}
