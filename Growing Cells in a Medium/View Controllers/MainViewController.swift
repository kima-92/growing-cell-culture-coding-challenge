//
//  MainViewController.swift
//  Growing Cells in a Medium
//
//  Created by macbook on 2/19/21.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    var cellController = CellController()
    
    // MARK: - Outlets
    
    @IBOutlet weak var hoursCountLabel: UILabel!
    @IBOutlet weak var occupiedCountLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    
    // MARK: - DidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellController.createCells()
    }
    
    // MARK: - Actions
    
    @IBAction func startDistributingCulturesButtonTapped(_ sender: UIButton) {
        startItirating()
    }
    
    // MARK: - Methods
    
    // Grow cells till the Grid stabilizes
    private func startItirating() {
        while cellController.didChanged {
            cellController.growCells()
        }
        
        let livCount = Float(cellController.livableSpacesCount)
        let cultCount = Float(cellController.culturedCount)
        let percentage = livCount / cultCount
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumIntegerDigits = 2
        formatter.locale = Locale(identifier: "en_US")
        
        // Updating Views
        hoursCountLabel.text = String(cellController.itirationCount)
        occupiedCountLabel.text = String(cellController.culturedCount)
        percentageLabel.text = formatter.string(from: NSNumber(value: percentage))
    }
}
