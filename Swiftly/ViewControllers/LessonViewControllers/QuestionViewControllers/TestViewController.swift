//
//  TestViewController.swift
//  Swiftly
//
//  Created by Guillermo Garcia Perez on 13/3/24.
//

import UIKit

class TestViewController: UIViewController, LessonElement {

    
    // MARK: - Variables
    
    // Protocol Variables
    var delegate: LessonViewController!
    var data: [String]!
    var number : Int!
    
    // Storyboard variables
    @IBOutlet weak var questionTittleLabel: UILabel!
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var leftStackView: UIStackView!
    @IBOutlet weak var rightStackView: UIStackView!
    
    
    // Other variables
    var testType : QuestionTypes!
    var answer : Int!
    
    
    // MARK: - View Controller Events
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.questionTittleLabel.text = "Question \(number)"
        self.questionTextView.text = self.data.first
        
        // Handle stack views for different test types
        switch testType {
            case .trueOrFalse:
                
            case .oneChoice:
            
            
            case.multipleChoice:
            
            
            default:
                print("Error")
            }
        
    }
    
    
    // MARK: - Actions
    
    @IBAction func nextButton(_ sender: Any) {
        self.delegate.next()
    }
    
    // MARK: - Protocol
    
    func setup(data: [String], delegate: LessonViewController, counter: Int, type: LessonElementTypes) {
        
        self.delegate = delegate
        self.number = counter
        self.data = data
        
        self.testType = type.type
    }

}
