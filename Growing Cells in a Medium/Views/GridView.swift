//
//  GridView.swift
//  Growing Cells in a Medium
//
//  Created by macbook on 2/7/21.
//

import UIKit

class GridView: UIView {
    
    // MARK: - Properties
    
    var columns: Int?
    var rows: Int?
    var cellSize: CGFloat?
    
    // MARK: - Methods
    
    override func draw(_ rect: CGRect) {
        guard let rows = rows,
              let columns = columns,
              let cellSize = cellSize else { return }
        
        var x: CGFloat = 0
        var y: CGFloat = 0
        
        if let context = UIGraphicsGetCurrentContext() {
            
            // Drawing a CGRect for each cell
            for row in 0...rows {
                for column in 0...columns {
                    
                    let square = CGRect(x: x, y: y, width: cellSize, height: cellSize)
                    
                    context.setFillColor(UIColor.red.cgColor)
                    context.fill(square)
                    context.setStrokeColor(UIColor.black.cgColor)
                    context.stroke(square)
                    
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
    func setGridSize(elements: [String], cellSize: CGFloat) {
        self.rows = elements.count
        self.columns = elements[0].count
        self.cellSize = cellSize
        
        // TODO: - Don't assume each row has the same count
    }
}
