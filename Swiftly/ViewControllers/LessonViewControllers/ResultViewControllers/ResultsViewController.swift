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
    var timer = 0 // Results aren't times
    var stopTimer = true
    
    // Storyboard Variables
    @IBOutlet weak var checkpointTitleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    // Other Variabls
    var data : ResultsElement!
    
    
    // MARK: - View Controller Events

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Do any additional setup after loading the view.
        switch self.data.type {
            case .results(type: .final):
                self.nextButton.setTitle("Back to Roadmap", for: .normal)
            
                self.checkpointTitleLabel.text = data.title
                self.messageLabel.text = data.message
                self.scoreLabel.text = data.results.first
            
            case .results(type: .intermediate):
                self.nextButton.setTitle("Keep Going", for: .normal)
            
                self.checkpointTitleLabel.text = "You're going great (?)"
                self.checkpointTitleLabel.text = "Implement intermediate checkpoint"
            default:
                print("Error, this shouldn't occur!")
        }
    }
    
    
    // MARK: - Actions
    
    @IBAction func nextButton(_ sender: Any) {
        self.delegate.next(result: [], timer: -1)
    }
    
    
    // MARK: - Protocols
    
    func setup(data: LessonElement, delegate: LessonViewController, counter: Int, timer : Int, isReview: Bool) {
        self.delegate = delegate
        self.number = counter
        self.data = data as? ResultsElement
    }
}
