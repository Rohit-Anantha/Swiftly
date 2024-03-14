//
//  CheckpointViewController.swift
//  Swiftly
//
//  Created by Guillermo Garcia Perez on 11/3/24.
//

import UIKit

class CheckpointViewController: UIViewController, LessonElementViewController {
    
    
    // MARK: - Variables
    
    // Protocol Variables
    
    var delegate: LessonViewController!
    var number: Int!
    
    
    // Storyboard Variables
    @IBOutlet weak var checkpointTittleLabel: UILabel!
    @IBOutlet weak var checkpointTextView: UITextView!
    
    // Other Variables
    var data: CheckpointElement!
    
    // MARK: - View Controller Events

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.checkpointTittleLabel.text = self.data.tittle
        self.checkpointTextView.text = self.data.message
        
    }
    
    
    // MARK: - Actions
    
    @IBAction func nextButton(_ sender: Any) {
        self.delegate.next(result: [])
    }
    
    
    // MARK: - Protocols
    
    func setup(data: LessonElement, delegate: LessonViewController, counter: Int) {
        self.delegate = delegate
        self.number = counter
        self.data = data as? CheckpointElement
    }
}
