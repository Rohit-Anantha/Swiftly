//
//  CheckpointViewController.swift
//  Swiftly
//
//  Created by Guillermo Garcia Perez on 11/3/24.
//

import UIKit

class CheckpointViewController: UIViewController, LessonElementViewController {
    
    // MARK: - Documentation
    
    /*
     VC for checkpoints, not implemeted for now, only basics. In the future this will show a message and adttional info.
     The user will be allowed to go back to roadmap from here.
     */
    
    
    // MARK: - Variables
    
    // Protocol Variables
    var delegate: LessonViewController!
    var number: Int!
    var timer = 0 // Checkpoints aren't timed
    var stopTimer = true
    
    // Storyboard Variables
    @IBOutlet weak var checkpointTitleLabel: UILabel!
    @IBOutlet weak var checkpointTextView: UITextView!
    
    // Other Variables
    var data: CheckpointElement!
    
    // MARK: - View Controller Events

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.checkpointTitleLabel.text = self.data.title
        self.checkpointTextView.text = self.data.message
        
    }
    
    
    // MARK: - Actions
    
    @IBAction func nextButton(_ sender: Any) {
        self.delegate.next(result: [], timer: -1)
    }
    
    
    // MARK: - Protocols
    
    func setup(data: LessonElement, delegate: LessonViewController, counter: Int, timer : Int, isReview: Bool) {
        self.delegate = delegate
        self.number = counter
        self.data = data as? CheckpointElement
    }
}
