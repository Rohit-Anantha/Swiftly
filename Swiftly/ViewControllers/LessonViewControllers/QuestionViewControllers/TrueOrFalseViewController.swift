//
//  TrueFalseViewController.swift
//  Swiftly
//
//  Created by Guillermo Garcia Perez on 9/3/24.
//

// View Controller for Lesson Questions with True or False answer

import UIKit

class TrueOrFalseViewController: UIViewController, LessonElement {
    
    
    // MARK: - Variables
    
    var delegate: LessonViewController!
    
    var answer : Bool!
    
    @IBOutlet weak var questionTittleLabel: UILabel!
    @IBOutlet weak var questionTextView: UITextView!
    
    // MARK: - View Controller Events

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - Actions

    @IBAction func trueButton(_ sender: Any) {
        
        self.answer = true
    }
    
    @IBAction func falseButton(_ sender: Any) {
        
        self.answer = false
    }
    
    @IBAction func nextButton(_ sender: Any) {
        if self.answer != nil{
            self.delegate.next()
        }
    }
    
    // MARK: - Protocols
    
    func setup(data: [String], delegate: LessonViewController, counter: Int) {
        
        self.delegate = delegate
        
        self.questionTittleLabel.text = "Question \(counter)"
        self.questionTittleLabel.text = data.first
    }
}
