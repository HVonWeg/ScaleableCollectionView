//
//  Sequence+Extensions.swift
//  Kachel
//
//  Created by Heiko von Wegerer on 19.12.21.
//

import Foundation

extension Sequence where Element: AdditiveArithmetic {
    func sum() -> Element { reduce(.zero, +) }
}
