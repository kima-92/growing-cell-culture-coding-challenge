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
    var didChanged = true
    var itirationCount = 0
    var culturedCount = 0
    var livableSpacesCount = 0
    
    // MARK: - Methods
    
    // Setting the next generation of the Grid
    func growCells() {
        didChanged = false
        self.culturedCount = 0
        var stateGrid: [[CellState]] = []
        
        // Saving the next state of each cell
        for (rowIndex, _) in cellGrid.enumerated() {
            stateGrid.append([])
            
            for cell in cellGrid[rowIndex] {
                stateGrid[rowIndex].append(cell.stateForNextGeneration())
            }
        }
        
        // Changing the state of each cell
        for (rowIndex, _) in cellGrid.enumerated() {
            for (cellIndex, cell) in cellGrid[rowIndex].enumerated() {
                var culturedCount = 0
                if cell.state == .cultured { culturedCount = 1 }
                
                if cell.state != stateGrid[rowIndex][cellIndex] {
                    cell.state = stateGrid[rowIndex][cellIndex]
                    if cell.state == .cultured { culturedCount = 1 }
                    didChanged = true
                }
                self.culturedCount += culturedCount
            }
        }
        if didChanged == true { itirationCount += 1 }
    }
    
    // Creating the CultureCell 2D array
    func createCells() {
        guard let stringArray = fetchData() else { return }
        
        // Map through each string, then through each character
        // to create a 2D array of CultureCells
        cellGrid = stringArray.map { (string) in
            let cellRow = string.map { (character) -> CultureCell in
                let cell = CultureCell(character: character)
                if cell.state != .unlivable { livableSpacesCount += 1 }
                return cell
            }
            return cellRow
        }
        
        if !cellGrid.isEmpty {
            setupNeighbors()
        }
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
