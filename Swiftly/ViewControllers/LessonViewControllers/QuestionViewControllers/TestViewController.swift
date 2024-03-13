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
    var multipleChoice : Bool!
    
    
    // MARK: - View Controller Events
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.questionTittleLabel.text = "Question \(number!)"
        self.questionTextView.text = self.data.first
        
        // Handle stack views for different test types
        switch testType {
            case .trueOrFalse:
            
            self.multipleChoice = false
            
            // True button
            let trueButton = UIButton()
            trueButton.setTitle("True", for: .normal)
            self.leftStackView.addArrangedSubview(trueButton)
            
            // False button
            let falseButton = UIButton()
            falseButton.setTitle("True", for: .normal)
            self.rightStackView.addArrangedSubview(falseButton)
            
            
            default:
            
                switch testType {
                    case .oneChoice:
                        self.multipleChoice = false
                    case.multipleChoice:
                        self.multipleChoice = true
                    default:
                        print("Error, this shouldn't happen!")
                }
            
            for i in 1..<self.data.count{
                
                let button = UIButton()
                button.setTitle(data[i], for: .normal)
                
                if i%2==0 {
                    self.leftStackView.addArrangedSubview(button)
                } else {
                    self.rightStackView.addArrangedSubview(button)
                }
            }
                
            
            
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
        
        switch type {
                
            case .question(type: .trueOrFalse):
                self.testType = .trueOrFalse
            case .question(type: .oneChoice):
                self.testType = .oneChoice
            case .question(type: .multipleChoice):
                self.testType = .dragAndDrop
            default:
                print("Error, this shouldn't happen!")
        }
    }

}
