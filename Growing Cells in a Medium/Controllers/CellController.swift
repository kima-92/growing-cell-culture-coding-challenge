//
//  CellController.swift
//  Growing Cells in a Medium
//
//  Created by macbook on 2/10/21.
//

import UIKit

class CellController {
    
    // MARK: - Properties
    
    var cellGrid: [[CultureCell]] = []
    var cellSize: CGFloat?
    
    // MARK: - Methods
    
    // Creating the CultureCell 2D array
    func createCells() -> [[CultureCell]]? {
        guard let stringArray = fetchData() else { return nil }
        
        // Map through each string, then through each character
        // to create a 2D array of CultureCells
        cellGrid = stringArray.map { (string) in
            let cell = string.map { (character) in
                CultureCell(character: character)
            }
            return cell
        }
        
        if !cellGrid.isEmpty {
            setupNeighbors()
        }
        return cellGrid
    }
    
    // Set the neighboring cells for each cell
    private func setupNeighbors() {
        
        for (rowIndex, row) in cellGrid.enumerated() {
            for (cellIndex, cell) in cellGrid[rowIndex].enumerated() {
                
                // Right Side
                if cellIndex + 1 <= cellGrid[rowIndex].count - 1 {
                    cell.neighbors.append(row[cellIndex + 1])
                    
                    // Top Right
                    if rowIndex - 1 >= 0 {
                        cell.neighbors.append(cellGrid[rowIndex - 1][cellIndex + 1])
                    }
                    // Bottom Right
                    if rowIndex + 1 <= cellGrid.count - 1 {
                        cell.neighbors.append(cellGrid[rowIndex + 1][cellIndex + 1])
                    }
                }
                
                // Left Side
                if cellIndex - 1 >= 0 {
                    cell.neighbors.append(row[cellIndex - 1])
                    
                    // Top Left
                    if rowIndex - 1 >= 0 {
                        cell.neighbors.append(cellGrid[rowIndex - 1][cellIndex - 1])
                    }
                    // Bottom Left
                    if rowIndex + 1 <= cellGrid.count - 1 {
                        cell.neighbors.append(cellGrid[rowIndex + 1][cellIndex - 1])
                    }
                }
                
                // Top
                if rowIndex - 1 >= 0 {
                    cell.neighbors.append(cellGrid[rowIndex - 1][cellIndex])
                }
                // Bottom
                if rowIndex + 1 <= cellGrid.count - 1 {
                    cell.neighbors.append(cellGrid[rowIndex + 1][cellIndex])
                }
            }
        }
    }
    
    // Extracting grid data from .txt file
    private func fetchData() -> [String]? {
        
        // Get file path to txt file
        if let filePath = Bundle.main.path(forResource: "cell-cultures", ofType: "txt") {
            
            // Try extracting data or return nil
            if let dataString = try? String(contentsOfFile: filePath) {
                var completeStringArray = dataString.components(separatedBy: "\n")
                
                // Remove the last element if it's empty
                if let lastElement = completeStringArray.last,
                   lastElement.isEmpty {
                    _ = completeStringArray.popLast()
                }
                return completeStringArray
            }
        }
        return nil
    }
}
