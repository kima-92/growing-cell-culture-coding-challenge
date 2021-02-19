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
    
    private func startItirating() {
        while cellController.didChanged {
            cellController.growCells()
        }
        
        hoursCountLabel.text = String(cellController.itirationCount)
        occupiedCountLabel.text = String(cellController.culturedCount)
    }
}
