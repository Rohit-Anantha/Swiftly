//
//  MultipleChoiceViewController.swift
//  Swiftly
//
//  Created by Guillermo Garcia Perez on 9/3/24.
//

// View Controller for Lesson Questions with multiple correct answers

import UIKit

class MultipleChoiceViewController: UIViewController, LessonElement {

    
    // MARK: - Variables
    
    var data : [String]!
    var delegate: LessonViewController!

    @IBOutlet weak var questionTittleLabel: UILabel!
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var stackView: UIStackView!
    
    
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
        
        self.questionTittleLabel.text = self.data.first
        
        // Set it up
        for i in 1..<self.data.count {
            let button = UIButton()
            button.setTitle(self.data[i], for: .normal)
            
            stackView.addArrangedSubview(button)
        }
    }
}
