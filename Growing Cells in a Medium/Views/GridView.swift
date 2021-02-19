//
//  GridView.swift
//  Growing Cells in a Medium
//
//  Created by macbook on 2/7/21.
//

import UIKit

class GridView: UIView {
    
    // MARK: - Properties
    
    var cellController: CellController?
    var cellSize: CGFloat?
    
    var cell: CultureCell?
    
    // MARK: - Draw Method
    
    override func draw(_ rect: CGRect) {
        guard let cellController = cellController else { return }
        
//        if cellController.cells == nil {
//            firstTimeDraw()
//        } else {
//            redrawGrid()
//        }
    }
    
    // MARK: - Methods
    
    private func firstTimeDraw() {
//        guard let cellController = cellController,
//              let cellSize = cellSize,
//              let stringArray = cellController.stringArray  else { return }
//
//        var x: CGFloat = 0
//        var y: CGFloat = 0
//
//        if let context = UIGraphicsGetCurrentContext() {
//            var characterIndex = 0
//
//            // Drawing a CGRect and creating a cell for each character
//            for string in stringArray {
//                for character in string {
//
//                    let square = CGRect(x: x, y: y, width: cellSize, height: cellSize)
//
//                    var state: CellState = .livable
//                    switch character {
//                    case "L":
//                        state = .livable
//                    case "#":
//                        state = .cultured
//                    case ".":
//                        state = .unlivable
//                    default:
//                        state = .unlivable
//                    }
//
//                    cellController.createCell(character: character, characterIndex: characterIndex, x: x, y: y, state: state, cgRect: square)
//
//                    // Color square based on initial state
//                    if character == "L" {
//                        context.setFillColor(UIColor.green.cgColor)
//                        context.fill(square)
//                    } else if character == "." {
//                        context.setFillColor(UIColor.red.cgColor)
//                        context.fill(square)
//                    } else if character == "#" {
//                        context.setFillColor(UIColor.systemPink.cgColor)
//                        context.fill(square)
//                    }
//
//                    x += cellSize
//                    characterIndex += 1
//                }
//                // Restart x for the next row
//                x = 0
//                y += cellSize
//            }
//        }
    }
    
    private func redrawGrid() {
        
//        guard let cellController = cellController,
//              let cells = cellController.cells,
//              let cellSize = cellSize else { return }
//        
//        var x: CGFloat = 0
//        var y: CGFloat = 0
//        
//        if let context = UIGraphicsGetCurrentContext() {
//            
//            // Fetching the next state for this cell and drawing accordingly
//            for cell in cells {
//                
//                guard let square = cell.rect else { return }
//                let nextstate = cellController.getNextStateFor(cell: cell)
//                
//                // Color square based on initial state
//                if nextstate == .livable {
//                    context.setFillColor(UIColor.green.cgColor)
//                    context.fill(square)
//                } else if nextstate == .unlivable{
//                    context.setFillColor(UIColor.red.cgColor)
//                    context.fill(square)
//                } else  if nextstate == .cultured {
//                    context.setFillColor(UIColor.systemPink.cgColor)
//                    context.fill(square)
//                }
//                x += cellSize
//            }
//            // Restart x for the next row
//            x = 0
//            y += cellSize
//        }
    }
}
