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
    var number : Int!
    
    @IBOutlet weak var questionTittleLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var questionTextView: UITextView!
    
    
    // MARK: - View Controller Events

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.questionTittleLabel.text = "Question \(number!)"
        self.questionTextView.text! = self.data.first!
        
        // Set it up
        for i in 1..<self.data.count {
            let button = UIButton()
            button.setTitle(self.data[i], for: .normal)
            
            stackView.addArrangedSubview(button)
        }
    }

    
    // MARK: - Actions

    @IBAction func nextButton(_ sender: Any) {
        delegate.next()
    }
    
    
    // MARK: - Protocols
    
    func setup(data: [String], delegate: LessonViewController, counter: Int) {
        
        self.delegate = delegate
        self.data = data
        self.number = counter
    }
}
