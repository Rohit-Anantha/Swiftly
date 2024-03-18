//
//  TestViewController.swift
//  Swiftly
//
//  Created by Guillermo Garcia Perez on 13/3/24.
//

import UIKit

class TestViewController: UIViewController, LessonElementViewController {
    
    // MARK: - Documentation
    
    /*
     VC for test question types. There are three types: true or falce, multiple choice, only one choice.
     
     Needs redesigning to make it look pretty, but basics are there.
     */
    

    // MARK: - Variables
        
    // Protocol Variables
    var delegate: LessonViewController!
    var number: Int!
    
    // Storyboard variables
    @IBOutlet weak var questionTittleLabel: UILabel!
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var leftStackView: UIStackView!
    @IBOutlet weak var rightStackView: UIStackView!
    
    
    // Other variables
    var data: TestQuestionElement!
    var answers : [Int] = []
    var multipleChoice : Bool!
    
    
    // MARK: - View Controller Events
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.questionTittleLabel.text = "Question \(number!)"
        self.questionTextView.text = self.data.question
        
        // Handle stack views for different test types
        self.leftStackView.distribution = .equalSpacing
        self.rightStackView.distribution = .equalSpacing
        
        switch self.data.type {
        case .question(type: .trueOrFalse):
                self.multipleChoice = false

                // False button
                let falseButton = UIButton()
                falseButton.setTitle("False", for: .normal)
                falseButton.backgroundColor = .red
                falseButton.tag = 0
                self.rightStackView.addArrangedSubview(falseButton)
                falseButton.addTarget(self, action: #selector(answerButton), for: .touchUpInside)
                
                // True button
                let trueButton = UIButton()
                trueButton.setTitle("True", for: .normal)
                trueButton.backgroundColor = .green
                trueButton.tag = 1
                self.leftStackView.addArrangedSubview(trueButton)
                trueButton.addTarget(self, action: #selector(answerButton), for: .touchUpInside)

            default:
                // Fot multiple or only one choice test questions
            switch self.data.type {
                    case .question(type: .oneChoice):
                        self.multipleChoice = false
                    case .question(type: .multipleChoice):
                        self.multipleChoice = true
                    default:
                        print("Error, this shouldn't happen!")
                }
            
            for i in 0..<self.data.answers.count{
                
                let button = UIButton()
                button.setTitle(self.data.answers[i], for: .normal)
                button.backgroundColor = .red
                button.tag = i
                
                button.addTarget(self, action: #selector(answerButton), for: .touchUpInside)
                
                if i%2==0 {
                    self.leftStackView.addArrangedSubview(button)
                } else {
                    self.rightStackView.addArrangedSubview(button)
                }
            }
        }
    }
    
    
    // MARK: - Actions
    
    // Next lesson element
    @IBAction func nextButton(_ sender: Any) {
        if self.answers.count > 0 {
            self.delegate.next(result: self.answers)
        }
    }
    
    // Action executed after user presses on a answer
    @objc func answerButton(sender: UIButton!) {
        if let buttonSender : UIButton = sender {
            if self.multipleChoice || self.answers.count == 0 {
                self.answers.append(buttonSender.tag)
            }
        }
    }
    
    // MARK: - Protocol
    
    // Set up the variables from which this lesson element creates itself
    func setup(data: LessonElement, delegate: LessonViewController, counter: Int) {
        self.delegate = delegate
        self.number = counter
        self.data = data as? TestQuestionElement
    }
}
