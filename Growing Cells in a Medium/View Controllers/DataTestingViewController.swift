//
//  DataTestingViewController.swift
//  Growing Cells in a Medium
//
//  Created by macbook on 2/7/21.
//

import UIKit

class DataTestingViewController: UIViewController {
    
    // MARK: - Properties
    
    var rows: [String]?
    
    // MARK: - Outlets
    
    @IBOutlet weak var dataLabel: UILabel!
    
    // MARK: - DidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        updateViews()
    }
    
    // MARK: - Methods
    
    // Extracting grid data
    private func getData() {
        
        // Get file path to txt file
        if let filePath = Bundle.main.path(forResource: "cell-cultures", ofType: "txt") {
            
            // Try extracting data
            if let dataString = try? String(contentsOfFile: filePath) {
                rows = dataString.components(separatedBy: "\n")
            }
        }
    }
    
    // Update UI
    private func updateViews() {
        guard let rows = rows else { return }
        dataLabel.text = rows[0]
    }
}
