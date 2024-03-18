//
//  ResultsViewController.swift
//  Swiftly
//
//  Created by Guillermo Garcia Perez on 9/3/24.
//

import UIKit

class ResultsViewController: UIViewController, LessonElementViewController {
    
    // MARK: - Documentation
    
    /*
     VC for results, not implemeted for now, only basics. In the future this will show the results and some additional info like 'You're doing great!'.
     */
    
    
    // MARK: - Variables
    
    // Protocol Variables
    var delegate: LessonViewController!
    var number: Int!
    
    
    // Storyboard Variables
    @IBOutlet weak var checkpointTittleLabel: UILabel!
    @IBOutlet weak var checkpointTextView: UITextView!
    @IBOutlet weak var nextButton: UIButton!
    
    // Other Variabls
    var data : ResultsElement!
    
    
    // MARK: - View Controller Events

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        switch self.data.type {
            case .results(type: .final):
                self.nextButton.setTitle("Back to Roadmap", for: .normal)
            
            self.checkpointTittleLabel.text = "You're results are..."
            self.checkpointTextView.text = "These screens ahve not been designed yet, in the future here the results (time and erros) will be shown"
            
            case .results(type: .intermediate):
                self.nextButton.setTitle("Keep Going", for: .normal)
            
                self.checkpointTittleLabel.text = "You're going great (?)"
                self.checkpointTittleLabel.text = "Implement intermediate checkpoint"
            default:
                print("Error, this shouldn't occur!")
        }
    }
    
    
    // MARK: - Actions
    
    @IBAction func nextButton(_ sender: Any) {
        self.delegate.next(result: [])
    }
    
    
    // MARK: - Protocols
    
    func setup(data: LessonElement, delegate: LessonViewController, counter: Int) {
        self.delegate = delegate
        self.number = counter
        self.data = data as? ResultsElement
    }
}
