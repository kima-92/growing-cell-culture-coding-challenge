//
//  Collection+Extension.swift
//  Growing Cells in a Medium
//
//  Created by macbook on 2/10/21.
//

import Foundation

extension Collection {
    
    // Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
