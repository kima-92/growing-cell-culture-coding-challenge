//
//  GridViewController.swift
//  Growing Cells in a Medium
//
//  Created by macbook on 2/7/21.
//

import UIKit

class GridViewController: UIViewController {
    
    // MARK: - Properties
    
    var cellController = CellController()
    
    var rows: [String]?
    var cellSize: CGFloat?
    
    var isGridStable: Bool = false
    var timerCount = 0
    
    // MARK: - Outlates
    
    @IBOutlet weak var gridView: GridView!
    
    // MARK: - DidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpGrid()
        cellController.createCells()
//        fireTimer() // TODO: - Put this back!
    }
    
    // MARK: - Actions
    
    @IBAction func redrawButtonTapped(_ sender: UIButton) {
        gridView.setNeedsDisplay()
    }
    
    // MARK: - Methods
    
    // Timer
    private func fireTimer() {
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] timer in
            
            if timerCount == 5 {
                timer.invalidate()
                gridView.setNeedsDisplay()
            } else {
                gridView.setNeedsDisplay()
                timerCount += 1
                print("Count: \(timerCount)")
            }
            
//            // If the Grid is stable, stop refreshing the Grid
//            if isGridStable {
//                timer.invalidate()
//            } else {
//                gridView.setNeedsDisplay()
//            }
            // TODO: - ^^ Add real logic after isGridStable is functional
        }
    }
    
    // Set up the Grid View
    private func setUpGrid(isRed: Bool = false) {
//        guard let stringArray = cellController.fetchData() else { return }
//        
//        // Size of the Screen
//        let viewWidth = view.frame.maxX - 20
//        let viewHeight = view.frame.maxY / 2
//        
//        // Divide the screen size by the amount of rows and columns needed
//        let cellWidth = viewWidth / CGFloat(stringArray[0].count)
//        let cellHeight = viewHeight / CGFloat(stringArray.count)
//        
//        // Set the cellSize
//        if cellWidth <= cellHeight {
//            cellSize = cellWidth
//        } else {
//            cellSize = cellHeight
//        }
//        
//        guard let cellSize = cellSize else { return }
//        cellController.cellSize = cellSize
//        gridView.cellController = cellController
//        gridView.cellSize = cellSize
    }
}
