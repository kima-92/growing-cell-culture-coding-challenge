//
//  StringProtocol+Extension.swift
//  Growing Cells in a Medium
//
//  Created by macbook on 2/10/21.
//

import Foundation

extension StringProtocol {
    subscript(offset: Int) -> Character? {
        let mIndex = Index(utf16Offset: offset, in: self)
        return indices.contains(mIndex) ? self[index(startIndex, offsetBy: offset)] : nil
    }
}
