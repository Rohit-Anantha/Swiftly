//
//  CheckpointViewController.swift
//  Swiftly
//
//  Created by Guillermo Garcia Perez on 11/3/24.
//

import UIKit

class CheckpointViewController: UIViewController, LessonElement {
    
    
    // MARK: - Variables
    
    // Protocol Variables
    var delegate: LessonViewController!
    var number: Int!
    var data: [String]!
    
    // Storyboard Variables
    @IBOutlet weak var checkpointTittleLabel: UILabel!
    @IBOutlet weak var checkpointTextView: UITextView!
    
    // MARK: - View Controller Events

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.checkpointTittleLabel.text = self.data.first
        self.checkpointTextView.text = self.data[1]
        
    }
    
    
    // MARK: - Actions
    
    @IBAction func nextButton(_ sender: Any) {
        self.delegate.next(result: [])
    }
    
    
    // MARK: - Protocols
    
    func setup(data: [String], delegate: LessonViewController, counter: Int, type: LessonElementTypes) {
        self.delegate = delegate
        self.data = data
        self.number = counter
    }
}
