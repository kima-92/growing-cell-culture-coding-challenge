//
//  CellController.swift
//  Growing Cells in a Medium
//
//  Created by macbook on 2/10/21.
//

import UIKit

class CellController {
    
    // MARK: - Properties
    
    var cells: [CultureCell]?
    var cellSize: CGFloat?
    var stringArray: [String]?

    var characterIndex = 0
    var rowIndex = 0
    var id = 0
    
    
    // MARK: - Methods
    
    func createCell(character: String.Element, characterIndex: Int, x: CGFloat, y: CGFloat, state: CellState, cgRect: CGRect) {
        if cells == nil { cells = [] }
        
        let cell = CultureCell(id: id, indexID: characterIndex, character: character, color: nil, coordinates: Coordinates(x: x, y: y), state: state, rect: cgRect)
        cells?.append(cell)
        
        id += 1
    }
    
    // Fetch the neighborhood of One cell
    func getNeighborhoodFor(cell: CultureCell) -> NeigborhoodByID? {
        
        guard let cellSize = cellSize,
              let cells = cells else { return nil }
        
        var newNeighborhood = NeigborhoodByID()
        
        // This cell's coordinates
        let x = cell.coordinates.x
        let y = cell.coordinates.y
        
        // Predict coordinates for this cell's neighborhood
        let topCoordinates = Coordinates(x: x - cellSize, y: y)
        let bottomCoordinates = Coordinates(x: x + cellSize, y: y)
        let leftCoordinates = Coordinates(x: x, y: y - cellSize)
        let rightCoordinates = Coordinates(x: x, y: y + cellSize)
        
        let upperLeftCoordinates = Coordinates(x: x - cellSize, y: y - cellSize)
        let upperRightCoordinates = Coordinates(x: x - cellSize, y: y + cellSize)
        let bottomLeftCoordinates = Coordinates(x: x + cellSize, y: y - cellSize)
        let bottomRightCoordinates = Coordinates(x: x + cellSize, y: y + cellSize)
        
        // Store correct cells in Neighborhood
        for foundCell in cells {
            
            // Vertial & Horizontal
            
            if foundCell.coordinates.x == topCoordinates.x && foundCell.coordinates.y == topCoordinates.y {
                newNeighborhood.top = foundCell.indexID
            }
            
            else if foundCell.coordinates.x == bottomCoordinates.x && foundCell.coordinates.y == bottomCoordinates.y {
                newNeighborhood.bottom = foundCell.indexID
            }
            
            else if foundCell.coordinates.x == leftCoordinates.x && foundCell.coordinates.y == leftCoordinates.y {
                newNeighborhood.left = foundCell.indexID
            }
            
            else if foundCell.coordinates.x == rightCoordinates.x && foundCell.coordinates.y == rightCoordinates.y {
                newNeighborhood.right = foundCell.indexID
            }
            
            // Diagonal
            
            else if foundCell.coordinates.x == upperLeftCoordinates.x && foundCell.coordinates.y == upperLeftCoordinates.y {
                newNeighborhood.upperLeft = foundCell.indexID
            }
            
            else if foundCell.coordinates.x == upperRightCoordinates.x && foundCell.coordinates.y == upperRightCoordinates.y {
                newNeighborhood.upperRight = foundCell.indexID
            }
            
            else if foundCell.coordinates.x == bottomLeftCoordinates.x && foundCell.coordinates.y == bottomLeftCoordinates.y {
                newNeighborhood.bottomLeft = foundCell.indexID
            }
            
            else if foundCell.coordinates.x == bottomRightCoordinates.x && foundCell.coordinates.y == bottomRightCoordinates.y {
                newNeighborhood.bottomRight = foundCell.indexID
            }
        }
        return newNeighborhood
    }
    
    func getNextStateFor(cell: CultureCell) -> CellState? {
        
        guard cells != nil else { return nil }
        
        if cell.state != .unlivable {
            var neighborhood: [CultureCell] = []
            
            
            // Id's of all the neighboring cells (as an neigborhoodById Object)
            guard let neighborhoodByID = getNeighborhoodFor(cell: cell) else { return nil}
            
            // Array of ID's, of all the neighboring cells
            let ids = neighborhoodByID.cells
            
            // Fetch each none nil cell of this cell's neighborhood
            // And add it to the neighborhood array
            for id in ids {
                if let id = id {
                    neighborhood.append(self.cells![id])
                }
            }
            // Store the cultured cells
            _ = neighborhood.filter({$0.state == .livable})
            let culturedCells = neighborhood.filter({$0.state == .cultured})
            
            // Apply the Game of Life Rules to decide what's this cell's next state
            if cell.state == .livable && culturedCells.count <= 0 {
                self.cells?[cell.indexID].state = .cultured
                return .cultured
                
            } else if cell.state == .livable && culturedCells.count > 0 {
                self.cells?[cell.indexID].state = .livable
                return .livable
            }
            else if cell.state == .cultured && culturedCells.count >= 4 {
                self.cells?[cell.indexID].state = .livable
                return .livable
                
            } else if cell.state == .cultured && culturedCells.count < 4 {
                self.cells?[cell.indexID].state = .cultured
                return .cultured
            }
        }
        return cell.state
    }
    
    // Extracting grid data from .txt file
    func fetchData() -> [String]? {
        
        // Get file path to txt file
        if let filePath = Bundle.main.path(forResource: "cell-cultures", ofType: "txt") {
            
            // Try extracting data or return nil
            if let dataString = try? String(contentsOfFile: filePath) {
                let completeStringArray = dataString.components(separatedBy: "\n")
                
                // Spliting the complete array in half
                let splitArray = completeStringArray.split()
                stringArray = splitArray.left
                return stringArray
            }
        }
        return nil
    }
}
