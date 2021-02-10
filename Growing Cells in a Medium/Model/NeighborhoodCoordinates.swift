//
//  NeighborhoodCoordinates.swift
//  Growing Cells in a Medium
//
//  Created by macbook on 2/9/21.
//

import Foundation

struct NeighborhoodCoordinates {
    
    var cellsCoordinates: [Coordinates?] {
        
        let cells = [
            topCellCoordinates,
            bottomCellCoordinates,
            leftCellCoordinates,
            rightCellCoordinates,
            
            upperLeftCellCoordinates,
            upperRightCellCoordinates,
            bottomLeftCellCoordinates,
            bottomRightCellCoordinates
        ]
        return cells
    }
    
    var topCellCoordinates: Coordinates?
    var bottomCellCoordinates: Coordinates?
    var leftCellCoordinates: Coordinates?
    var rightCellCoordinates: Coordinates?
    
    var upperLeftCellCoordinates: Coordinates?
    var upperRightCellCoordinates: Coordinates?
    var bottomLeftCellCoordinates: Coordinates?
    var bottomRightCellCoordinates: Coordinates?
}
