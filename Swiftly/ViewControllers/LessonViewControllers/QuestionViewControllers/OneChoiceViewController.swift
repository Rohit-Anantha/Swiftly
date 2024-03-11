//
//  OneChoiceViewController.swift
//  Swiftly
//
//  Created by Guillermo Garcia Perez on 9/3/24.
//

// View Controller for Lesson Questions with only one correct answer

import UIKit

class OneChoiceViewController: UIViewController, LessonElement {
    

    // MARK: - Variables
    
    var delegate: LessonViewController!
    
    var data : [String]!
    
    @IBOutlet weak var questionTittleLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var questionTextView: UITextView!
    
    
    // MARK: - View Controller Events

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    // MARK: - Actions

    @IBAction func nextButton(_ sender: Any) {
        delegate.next()
    }
    
    
    // MARK: - Protocols
    
    func setup(data: [String], delegate: LessonViewController, counter: Int) {
        
        self.delegate = delegate
        self.data = data
        
        self.questionTittleLabel.text = "Question \(counter)"
        self.questionTittleLabel.text = self.data.first
        
        // Set it up
        for i in 1..<self.data.count {
            let button = UIButton()
            button.setTitle(self.data[i], for: .normal)
            
            stackView.addArrangedSubview(button)
        }
    }
}
