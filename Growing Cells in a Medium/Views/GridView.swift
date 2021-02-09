//
//  GridView.swift
//  Growing Cells in a Medium
//
//  Created by macbook on 2/7/21.
//

import UIKit

class GridView: UIView {
    
    // MARK: - Properties
    
    var elements: [String]?
    var columnsCount: Int?
    var rowsCount: Int?
    var cellSize: CGFloat?
    
    var isRed: Bool = false
    
    // MARK: - Methods
    
    override func draw(_ rect: CGRect) {
        guard let elements = elements,
              let _ = rowsCount,
              let _ = columnsCount,
              let cellSize = cellSize else { return }
        
        var x: CGFloat = 0
        var y: CGFloat = 0
        
        if let context = UIGraphicsGetCurrentContext() {
            
            // Drawing a CGRect for each cell
            for element in elements {
                for character in element {
                    
                    let square = CGRect(x: x, y: y, width: cellSize, height: cellSize)
                    
                    // Color square based on state
                    
                    
                    if isRed {
                        context.setFillColor(UIColor.red.cgColor)
                        context.fill(square)
                    }
                    else if character == "L" {
                        context.setFillColor(UIColor.green.cgColor)
                        context.fill(square)
                    } else if character == "." {
                        context.setFillColor(UIColor.red.cgColor)
                        context.fill(square)
                    }
                    
                    x += cellSize
                }
                // Restart x for the next row
                x = 0
                y += cellSize
            }
        }
    }
    
    // MARK: - Methods
    
    // Collect the data to size the grid
    func setGridSize(elements: [String], cellSize: CGFloat, isRed: Bool = false) {
        self.elements = elements
        self.rowsCount = elements.count
        self.columnsCount = elements[0].count
        self.cellSize = cellSize
        
        
        self.isRed = isRed
        
        // TODO: - Don't assume each row has the same count
    }
}
