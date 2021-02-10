//
//  NeigborhoodByID.swift
//  Growing Cells in a Medium
//
//  Created by macbook on 2/9/21.
//

import Foundation

struct NeigborhoodByID {
    
    var cells: [Int?] {
        
        let cells = [
            top,
            bottom,
            left,
            right,
            
            upperLeft,
            upperRight,
            bottomLeft,
            bottomRight
        ]
        return cells
    }
    
    var top: Int?
    var bottom: Int?
    var left: Int?
    var right: Int?
    
    var upperLeft: Int?
    var upperRight: Int?
    var bottomLeft: Int?
    var bottomRight: Int?
}
