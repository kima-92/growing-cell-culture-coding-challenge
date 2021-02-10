//
//  CultureCell.swift
//  Growing Cells in a Medium
//
//  Created by macbook on 2/8/21.
//

import UIKit

struct CultureCell {
    var id: Int
    var character: String.Element
    
    var x: CGFloat?
    var y: CGFloat?
    
    var color: CGColor?
    
    var indexID: Int
    var coordinates: Coordinates
    var state: CellState
    var neighborhoodByID: NeighborhoodCoordinates?
    var rect: CGRect
    var alpha: CGFloat
}
