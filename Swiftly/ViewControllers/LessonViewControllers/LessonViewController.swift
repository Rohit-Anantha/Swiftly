//
//  LessonViewController.swift
//  Swiftly
//
//  Created by Guillermo Garcia Perez on 9/3/24.
//

import UIKit

class LessonViewController: UIViewController {
    
    // MARK: - Variables
    
    /*
     Variable "data" will be used to store all the lesson's elements
     (lectures, questions and checkpoints) information. For now this variable will be populated
     with questions, in the future this variable should be assined a value obtained from firebase
     through the constructor
     */
    var data : [any LessonElement] = [
        // Lecture type
        LectureElement(type: .lecture(type: .lecture),
                       tittle: "Introduction to Swift Programing language!",
                       lecture: "Swift is a cool programing language used for iOS development an other stuff. Bla bla bla.."),
        // One Choice question type
        TestQuestionElement(type: .question(type: .oneChoice),
                            question: "What is an \"if else\" statement called?",
                            answers: 
                                ["Conditional Banching",
                                 "Looping Construct",
                                 "Protocol",
                                 "Class"],
                            correctAnswers: [1]),
        // True or False question type
        TestQuestionElement(type: .question(type: .trueOrFalse),
                            question: "Is Swift an interpreted language?",
                            answers: [], // This is empty because the answers are obviously true or false (it's a true or false question)
                            correctAnswers: [0]),
        //Checkpoint
        CheckpointElement(type: .checkpoint(type: .checkpoint),
                          tittle: "You're doing good...",
                          message: "idk what to say here, the design of checpoints is yet to be done"),
        // Multiple Choice question type
        TestQuestionElement(type: .question(type: .multipleChoice),
                            question: "Which of these keywords belong to swift?",
                            answers: ["elif",
                                        "while",
                                        "protocol",
                                        "Class",
                                        "func",
                                        "ret"],
                            correctAnswers: [1,2,4]),

        // Drag and Drop
        DragAndDropElement(type: .question(type: .dragAndDrop),
                           question: """
                                //Calculate factorial
                                fact = 10
                                _0 i in 1..<_1 {
                                    fact _2 i
                                    _3("fact is now \\(fact)")
                                }
                                _4("Result is \\(_5)")
                                """,
                           options: ["for", "if", "while", "do", "then",
                                     "10", "i", "fact", "main[1]", "nil",
                                     "=", "+", "*=", "in",
                                     "fact", "print", "do", "show",
                                     "if", "show", "print", "now",
                                     "result", "fact", "100", "fact(10)"],
                           correctOptions: [0, 2, 3, 1, 3, 1]),
        // Fill in the Blank question type
        //QuestionElement(...)
        // Results
        ResultsElement(type: .results(type: .final),
                       tittle: "Great job!",
                       message: "You did great! you're results are... (Not implemented)",
                       results: ["Yet to be implemented"])
    ]
    
    // User's answers
    var answers : [[Int]] = []
    
    // Counter to know what lesson element we're displaying
    var counter = 0
    
    // A bit of info about the lesson
    var lessonData : String = "Beginners lesson on Swift!!"
    
    // Current lesson element being displayed
    var currentElement : LessonElementViewController!
    
    
    // MARK: - View Controller Events
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
}
    
    
    // MARK: - Actions
    
    // This will start the lesson, it will take the user to the first lesson
    // element.
    // Maybe I should check if elementTypes is not empty
    @IBAction func start(_ sender: Any) {
        
        // Instantiate the next element
        self.currentElement = self.instantiateNextElement()
        
        // Set it up
        self.currentElement.setup(data: data.first!, delegate: self, counter: 0)
        
        // It's a child!
        self.addChild(self.currentElement)
        
        // Prepare to show it and show it
        self.currentElement.beginAppearanceTransition(true, animated: true)
        self.view.addSubview(self.currentElement.view)
        
        // We need to increase this
        counter+=1
        
    }
    
    
    // MARK: - Protocols
    
    // next will be called from each lesson element to show the next lesson element
    // result will be the result of a given question.
    func next(result : [Int]) {
        
        self.answers.append(result)
        
        if self.counter >= self.data.count {
            // Lesson ended, if result screen existed it was shown
            // Now just go back to roadmap
        }
        
        // This will be the next lesson element
        let next = self.instantiateNextElement()
        
        // Set it up
        next.setup(data: self.data[counter], delegate: self, counter: self.counter)
        
        // It's a child!
        self.addChild(next)
        
        // We have to let the current displayed element know that it will
        // soon disappear
        self.currentElement.willMove(toParent: nil)
        
        // Show the new element, I'm not sure how the parameters duration
        // and animations affect this
        self.transition(from: self.currentElement, to: next, duration: TimeInterval(1), animations: {})
        
        // Remove the previous element from the view
        self.currentElement.view.removeFromSuperview()
        self.currentElement.removeFromParent()
        
        // Update this
        self.currentElement = next
        
        counter+=1
    }
    
    
    // MARK: - Functions
    
    // Function used to create next lesson element using counter, data and dataType
    // Maybe I should catch if elementTypes is empty
    
    func instantiateNextElement() -> any LessonElementViewController {
                            
        switch self.data[self.counter].type {
            
        case .question(type: .oneChoice):
            return  UIStoryboard(name: "Test", bundle: nil).instantiateViewController(identifier: "Test") as! TestViewController
            
        case .question(type: .multipleChoice):
            return UIStoryboard(name: "Test", bundle: nil).instantiateViewController(identifier: "Test") as! TestViewController
            
        case .question(type: .trueOrFalse):
            return UIStoryboard(name: "Test", bundle: nil).instantiateViewController(identifier: "Test") as! TestViewController
            
        case .question(type: .fillTheBlank):
            return  UIStoryboard(name: "FillTheBlank", bundle: nil).instantiateViewController(identifier: "Fill The Blank") as! FillTheBlankViewController
            
        case .question(type: .dragAndDrop):
            return  UIStoryboard(name: "DragAndDrop", bundle: nil).instantiateViewController(identifier: "Drag And Drop") as! DragAndDropViewController
            
        case .lecture:
            return  UIStoryboard(name: "Lecture", bundle: nil).instantiateViewController(identifier: "Lecture") as! LectureViewController
            
        case .checkpoint:
            return  UIStoryboard(name: "Checkpoint", bundle: nil).instantiateViewController(identifier: "Checkpoint") as! CheckpointViewController

        case .results:
            return  UIStoryboard(name: "Results", bundle: nil).instantiateViewController(identifier: "Results") as! ResultsViewController
        }
    }

}
