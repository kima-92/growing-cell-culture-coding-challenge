//
//  TestingNeighborFetch.swift
//  Growing Cells in a Medium
//
//  Created by macbook on 2/10/21.
//

import Foundation

class TestingNeighborhoodFetch {
    
    // MARK: - Properties
    
    var originalGrid: [String]?
    var previousGrid: [String]?
    var newGrid: [String]?
    
    var didChange = false
    var itirationCount = 0
    var runCount = 0
    
    var culturedCellCount = 0
    var livableCellCount = 0
    
    // MARK: - Main Growth Itiration
    
    func growCultures() {
        
        guard let originalGrid = originalGrid else {
            print("No data was fetched")
            return
        }
        
        // Setup previousGrid and newGrid
        if let newGrid = newGrid { previousGrid = newGrid }
        else { previousGrid = originalGrid }
        guard let previousGrid = previousGrid else { return }
        
        // Set variables
        newGrid = []
        didChange = false
        runCount += 1
        
        culturedCellCount = 0
        livableCellCount = 0
        
        // Indexes
        var rowIndex = 0
        var characterIndex = 0
        
        // Ititrate through the Cells and update growth status
        for row in previousGrid {
            newGrid?.append("")
            for character in row {
                
                // Getting the non-nil neighborhood for this cell
                var top: Character? = nil
                var topLeft: Character? = nil
                var topRight: Character? = nil
                
                var bottom: Character? = nil
                var bottomLeft: Character? = nil
                var bottomRight: Character? = nil
                
                let left = row[characterIndex - 1]
                let right = row[characterIndex + 1]
                
                if rowIndex - 1 >= 0 {
                    top = previousGrid[rowIndex - 1][characterIndex]
                    topLeft = previousGrid[rowIndex - 1][characterIndex - 1]
                    topRight = previousGrid[rowIndex - 1][characterIndex + 1]
                }
                if rowIndex + 1 < previousGrid.count - 1 {
                    bottom = previousGrid[rowIndex + 1][characterIndex]
                    bottomLeft = previousGrid[rowIndex + 1][characterIndex - 1]
                    bottomRight = previousGrid[rowIndex + 1][characterIndex + 1]
                }
                let nonNilNeigbors = [top, topLeft, topRight, left, right, bottom, bottomLeft, bottomRight].compactMap({ $0 })
                
                // Run rules for this Cell
                if isAvailable(character: character, rowIndex: rowIndex) {
                    let growResult = willGrow(character: character, rowIndex: rowIndex, neighbors: nonNilNeigbors)
                    let dieResult = willDie(character: character, rowIndex: rowIndex, neighbors: nonNilNeigbors)
                    
                    // Did nothing rule - Passing the same character to the new grid if nothing changed
                    if growResult == "" && dieResult == "" {
                        if character == "#" { culturedCellCount += 1 }
                        else if character == "L" { livableCellCount += 1 }
                        newGrid?[rowIndex].append(character)
                    }
                }
                characterIndex += 1
            }
            characterIndex = 0
            rowIndex += 1
        }
        if didChange {
            itirationCount += 1
        }
    }
    
    // MARK: - Methods
    
    // Extracting grid data from .txt file
    private func fetchData() {
        
        // Get file path to txt file
        if let filePath = Bundle.main.path(forResource: "cell-cultures", ofType: "txt") {
            
            // Try extracting data
            if let dataString = try? String(contentsOfFile: filePath) {
                originalGrid = dataString.components(separatedBy: "\n")
            }
        }
    }
    
    // Checking if cell is livable
    func isAvailable(character: String.Element, rowIndex: Int) -> Bool {
        if character == "." {
            newGrid?[rowIndex].append(".")
            return false
        }
        return true
    }
    
    // Check if livable cell culture can grow
    func willGrow(character: String.Element, rowIndex: Int, neighbors: [Character?]) -> String {
        
        if character == "L" {
            
            for neighbor in neighbors {
                if neighbor != nil && neighbor == "#" {
                    newGrid?[rowIndex].append("L")
                    livableCellCount += 1
                    return "L"
                }
            }
            
            // If there's no grown cultures in neigborhood, this culture will grow (live)
            newGrid?[rowIndex].append("#")
            didChange = true
            culturedCellCount += 1
            return "#"
        }
        return ""
    }
    
    // Checking if cell culture will die
    func willDie(character: String.Element, rowIndex: Int, neighbors: [Character?]) -> String {
        
        // Get count of grown cultures in the neigborhood
        if character == "#" {
            var grownNeigborsCount = 0
            
            for neighbor in neighbors {
                if neighbor != nil && neighbor == "#" {
                    grownNeigborsCount += 1
                }
            }
            
            // If 4 or more surrounding cell cuntures are grown, this cell will die due to over population
            if grownNeigborsCount >= 4 {
                newGrid?[rowIndex].append("L") // Will die
                didChange = true
                livableCellCount += 1
                return "L"
            } else {
                newGrid?[rowIndex].append("#") // Will continue to grow
                culturedCellCount += 1
                return "#"
            }
        }
        return ""
    }
    
    // MARK: - Testing Method
    
    func testGrowingCells() {
        
        // Seting up the data and printing the original Grid
        fetchData()
        //originalGrid = ["L.LL.LL.LL", "LLLLLLL.LL"]
        //originalGrid = ["L.LL.LL.LL", "LLLLLLL.LL", "L.L.L..L..", "LLLL.LL.LL", "L.LL.LL.LL", "L.LLLLL.LL", "..L.L.....", "LLLLLLLLLL", "L.LLLLLL.L", "L.LLLLL.LL"]
        
        print("\noriginalGrid:\n")
        print(originalGrid)
        print("\n")
        
        // Start itiration until no more changes are made
        growCultures()
        while didChange {
            growCultures()
        }
        print(newGrid)
        print("\nitirationCount: \(itirationCount)")
        print("\n")
        print("\nrunCount: \(runCount)")
        print("\n")
        print("\nculturedCellCount: \(culturedCellCount)")
        print("\n")
        print("\nlivableCellCount: \(livableCellCount)")
        print("\n")
    }
}

/*
 ---------------------  Growing Cell Cultures ---------------------
     
     
     Zones which were Livable have a chance for the culture to take hold and grow. The culture takes hold according to a specific set of rules.
     
-------------------------------------------------------------------
 
    Rules:
     
     1.    The cells require room to blossom, so if a livable area is empty and there are no adjacent cell cultures, the cells will take hold and begin to grow
     
         *    Live - Blossom - Grow - Culture
         
         * If livable (L) and has no adjacent culture (#) -> it will grow into (#)
         
         
     2.    The cells are also subject to crowding, so if a culture is growing in a location where four or more adjacent locations are also occupied, then the culture dies back
     
         * Dies - Culture dies
         
         * If culture (#) in location where 4+ adjacent cultures (#)s -> it dies back to (L)
         
     
     3.    Otherwise, no change occurs
         
         * No changes
         
         * else, no changes ->  (L) = (L)   ||   (#) = (#)
         
     
     4.    Unlivable spaces are never occupied with a culture
     
         * Dead is Dead
         
         * (.) stays as (.)
 */
