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
     VC for test question types. There are three types: true or false, multiple choice, only one choice.
     
     Needs redesigning to make it look pretty, but basics are there.
     */
    
    
    // MARK: - Variables
    
    // Protocol Variables
    var delegate: LessonViewController!
    var number: Int!
    var timer = 0
    var stopTimer = false
    
    // Storyboard variables
    @IBOutlet weak var questionTitleLabel: UILabel!
    @IBOutlet weak var leftStackView: UIStackView!
    @IBOutlet weak var rightStackView: UIStackView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerSymbol: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    
    
    // Other variables
    var data: TestQuestionElement!
    var answers : [Int] = []
    var multipleChoice : Bool!
    var correctAnswers : [Int] = []
    
    // MARK: - View Controller Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.correctAnswers = data.correctAnswers
        
        if self.data.isTimed {
            // Set the timer up
            self.timerLabel.text = formatTime(timer)

            // Add the task that will decrease the timer
            let queue = DispatchQueue(label: "TimerQueue", qos: .default)
            queue.async {
                while !self.stopTimer && self.timer > 0 {
                    usleep(1000000)
                    DispatchQueue.main.async {
                        self.timer -= 1
                        self.timerLabel.text = self.formatTime(self.timer)
                    }
                }
                if self.timer <= 0 {
                    // TODO: User ran out of time, what do you do?
                    DispatchQueue.main.sync{
                        self.delegate.userRanOutOfTime()
                    }
                }
            }
            
        } else {
            self.timerLabel.isHidden = true
            self.timerSymbol.isHidden = true
        }
        
        // Do any additional setup after loading the view.
        let rtv = RoundedTextView()
        rtv.constrain(width: 300, height: 300)
        view.addSubview(rtv)
        rtv.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            // Center the RoundedTextView horizontally
            rtv.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            // Set the distance between the top of the view and the top of the RoundedTextView to 100 points
            rtv.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
        ])
        rtv.text = self.data.question
        
        self.questionTitleLabel.text = "Question \(number!)"
        // self.questionTextView.text = self.data.question
        
        // Handle stack views for different test types
        self.leftStackView.distribution = .fillEqually
        self.rightStackView.distribution = .fillEqually
        self.leftStackView.spacing = 20
        self.rightStackView.spacing = 20
        
        switch self.data.type {
        case .question(type: .trueOrFalse):
            self.multipleChoice = false
            
            // True button
            let trueButton = RoundedButton()
            trueButton.setTitle("True", for: .normal)
            trueButton.tag = 0
            self.leftStackView.addArrangedSubview(trueButton)
            trueButton.addTarget(self, action: #selector(answerButton), for: .touchUpInside)
            
            // False button
            let falseButton = RoundedButton()
            falseButton.setTitle("False", for: .normal)
            falseButton.tag = 1
            self.rightStackView.addArrangedSubview(falseButton)
            falseButton.addTarget(self, action: #selector(answerButton), for: .touchUpInside)
            
            
            
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
                
                let button = RoundedButton()
                button.setTitle(self.data.answers[i], for: .normal)
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
    
    // Function to format time as mm:ss
    func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.stopTimer = true
    }
    
    // MARK: - Actions
    
    // Next lesson element
    @IBAction func nextButton(_ sender: Any) {
        self.flashCorrectWrong {
            // After the animations complete, wait for a while before calling next
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.enableButtons()
                self.delegate.next(result: self.answers, timer: self.timer)
            }
        }
    }
    
    
    /// prevents user interaction with buttons (for animations and such)
    func disableButtons () {
        nextButton.isUserInteractionEnabled = false
        for button in self.leftStackView.subviews {
            button.isUserInteractionEnabled = false
        }
        for button in self.rightStackView.subviews {
            button.isUserInteractionEnabled = false
        }
    }
    
    
    /// enable all buttons to be clicked
    func enableButtons (){
        nextButton.isUserInteractionEnabled = true
        for button in self.leftStackView.subviews {
            button.isUserInteractionEnabled = true
        }
        for button in self.rightStackView.subviews {
            button.isUserInteractionEnabled = true
        }
    }
    
    func flashCorrectWrong(completion: (() -> Void)? = nil){
        if self.answers.count > 0 {
            disableButtons()
            UIView.animate(withDuration: 0.5, animations: {
                for button in self.leftStackView.subviews{
                    if self.correctAnswers.contains(button.tag) {
                        button.backgroundColor = UIColor(named: "correctAnswer")
                    }
                    else {
                        button.backgroundColor = UIColor(named: "wrongAnswer")
                    }
                }
                for button in self.rightStackView.subviews{
                    if self.correctAnswers.contains(button.tag) {
                        button.backgroundColor = UIColor(named: "correctAnswer")
                    }
                    else {
                        button.backgroundColor = UIColor(named: "wrongAnswer")
                    }
                }
            }) { (_) in
                // Call the completion closure after the animation completes
                completion?()
            }
        }
        
    }
    
    // clear all the colors to red
    // later will need to have some kind of "deselected color", "selected color"
    func clearColors(){
        for button in self.leftStackView.subviews{
            button.backgroundColor = UIColor(named: "offSelect")
        }
        for button in self.rightStackView.subviews{
            button.backgroundColor = UIColor(named: "offSelect")
        }
    }
    
    // Action executed after user presses on a answer
    @objc func answerButton(sender: UIButton!) {
        UIView.animate(withDuration: 0.15, animations: {
            sender.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { (_) in
            UIView.animate(withDuration: 0.1, animations: {
                sender.transform = .identity
            })
        }
        if let buttonSender : UIButton = sender {
            // if a button is already selected, remove it from the list of answers and make it green
            if buttonSender.backgroundColor == UIColor(named: "onSelect") {
                self.answers.removeAll(where: {$0 == buttonSender.tag})
                buttonSender.backgroundColor = UIColor(named: "offSelect")
            }
            // if this is a multiple choice question or we haven't selected an answer
            else if self.multipleChoice || self.answers.count == 0 {
                self.answers.append(buttonSender.tag)
                buttonSender.backgroundColor = UIColor(named: "onSelect")
            }
            // if we are in a single answer question and we've already got one selected
            // override the selection and choose the new one.
            else if !self.multipleChoice && self.answers.count == 1 {
                clearColors()
                self.answers = [buttonSender.tag]
                buttonSender.backgroundColor = UIColor(named: "onSelect")
            }
            
        }
    }
    
    // MARK: - Protocol
    
    // Set up the variables from which this lesson element creates itself
    func setup(data: LessonElement, delegate: LessonViewController, counter: Int, timer : Int) {
        self.delegate = delegate
        self.number = counter
        self.data = data as? TestQuestionElement
        self.timer = timer
    }
}
