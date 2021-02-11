//
//  Array+Extension.swift
//  Growing Cells in a Medium
//
//  Created by macbook on 2/11/21.
//

import Foundation

/*
Returning a named tuple of arrays to enforces the fact that you expect exactly two arrays as a result
 */

extension Array {
    func split() -> (left: [Element], right: [Element]) {
        let ct = self.count
        let half = ct / 2
        let leftSplit = self[0 ..< half]
        let rightSplit = self[half ..< ct]
        return (left: Array(leftSplit), right: Array(rightSplit))
    }
}
