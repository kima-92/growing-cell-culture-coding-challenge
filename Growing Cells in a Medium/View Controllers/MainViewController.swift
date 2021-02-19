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
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    // MARK: - DidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorView.hidesWhenStopped = true
        cellController.createCells()
    }
    
    // MARK: - Actions
    
    @IBAction func startDistributingCulturesButtonTapped(_ sender: UIButton) {
        startItirating()
    }
    
    // MARK: - Methods
    
    // Grow cells till the Grid stabilizes
    private func startItirating() {
        activityIndicatorView.startAnimating()
        
        // Running the growth of the cells on the background queue
        DispatchQueue.global(qos: .background).async {
            while self.cellController.didChanged {
                self.cellController.growCells()
            }
            
            // Updating the UI in the main queue, after the previous code in outer block
            DispatchQueue.main.async {
                let livCount = Float(self.cellController.livableSpacesCount)
                let cultCount = Float(self.cellController.culturedCount)
                let percentage = livCount / cultCount
                
                let formatter = NumberFormatter()
                formatter.numberStyle = .percent
                formatter.maximumIntegerDigits = 2
                formatter.locale = Locale(identifier: "en_US")
                
                // Views
                self.hoursCountLabel.text = String(self.cellController.itirationCount)
                self.occupiedCountLabel.text = String(self.cellController.culturedCount)
                self.percentageLabel.text = formatter.string(from: NSNumber(value: percentage))
                
                self.activityIndicatorView.stopAnimating()
            }
        }
    }
}
