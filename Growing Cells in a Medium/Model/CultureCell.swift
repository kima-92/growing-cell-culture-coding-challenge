//
//  CultureCell.swift
//  Growing Cells in a Medium
//
//  Created by macbook on 2/8/21.
//

import UIKit

class CultureCell {
    
    // MARK: - Properties
    
    var neighbors: [CultureCell] = []
    var state: CellState
    
    // MARK: - Initializer
    
    init(character: Character) {
        self.state = CellState(rawValue: character) ?? .unlivable
    }
    
    // MARK: - Next generation method
    
    func stateForNextGeneration() -> CellState {
        
        switch state {
        case .cultured:
            if !neighbors.isEmpty,
               neighbors.filter({$0.state == .cultured}).count >= 4 {
                return .livable
            } else {
                return .cultured
            }
        case .livable:
            if !neighbors.isEmpty,
               neighbors.filter({$0.state == .cultured}).count == 0 {
                return .cultured
            } else {
                return .livable
            }
        case .unlivable:
            return .unlivable
        }
    }
}

