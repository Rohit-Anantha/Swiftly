//
//  LessonViewController.swift
//  Swiftly
//
//  Created by Guillermo Garcia Perez on 9/3/24.
//

import UIKit

class LessonViewController: UIViewController {
    
    // MARK: - Documantation
    
    /*
     This view controller will be shown once a lesson is clicked in the roadmap. It will show a bried description of the lesson (not implemented)
     and allow the user to go back to the roadmap or start the lesson.
     
     This VC has a function called 'next', this is the function used to transition from lesson element to lesson element. For example, when a user
     answers a question and presses the 'next question' button the question VC calls delegate.next(). 'next' makes sure the current VC that is
     showing the question/lecture/checkpoint/results is dismissed and the next VC is displayed.
     
     The action 'start' will take the user to the first lesson element.
     */
    
    // MARK: - Variables
    
    /*
     Variable "data" will be used to store all the lesson's elements (lectures, questions and checkpoints) information.
     For now this variable will be hardcoded, in the future this variable should be assined a value obtained from
     firebase in the constructor through the constructor.
     */
    var data : [any LessonElement] = [
        // Lecture type
        LectureElement(type: .lecture(type: .lecture),
                       title: "Introduction to Swift Programing language!",
                       lecture: "Swift is a cool programing language used for iOS development an other stuff. This first lesson is hardcoded in to the app and it's just used to test the app. In the future screens like this will actually teach things..."),
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
                          title: "You're doing good...",
                          message: "You could add here aditional information, will be redesigned in the future"),
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
                           question:
                                ["//Calculate factorial\nfact = 10\n",//for
                                 " i in 1..< ",//fact
                                 " {\n\tfact ",//*=
                                 " i\n\tprint(\"fact is now \\(fact)\")\n}\n",//print
                                 "(\"Result is \\(",//fact
                                 ")\")"],
                           options: ["for", "do", "fact", "print", "nil",
                                     "=", "+", "*=", "fact"],
                           correctOptions: [0, 2, 7, 3, 8],
                          number: 5),
        // Fill in the Blank question type
        //QuestionElement(...)
        // Results
        ResultsElement(type: .results(type: .final),
                       title: "Great job!",
                       message: "You did great! you're results are... A++",
                       results: ["a"])
    ]
    
    var optional_lesson : [any LessonElement] = [
    
        LectureElement(type: .lecture(type: .lecture), title: "What are Optionals?", lecture: "An optional in Swift is a type that represents a value that may or may not exist. It is denoted by adding a question mark (?) after the type declaration."),
        
        LectureElement(type: .lecture(type: .lecture), title: "Declaring Optionals", lecture: "To declare an optional, you simply append a question mark (?) to the type. For example: \nvar optionalInt: Int?\nvar optionalString: String?"),
        
        LectureElement(type: .lecture(type: .lecture), title: "Unwrapping Optionals", lecture: "To access the value inside an optional, you need to unwrap it. There are several ways to do this, including optional binding and forced unwrapping."),
        
        LectureElement(type: .lecture(type: .lecture), title: "Optional Binding", lecture: "Optional binding is a safe way to unwrap optionals. It uses if let or guard let syntax to conditionally unwrap the optional and assign its value to a constant or variable.if let unwrappedValue = optionalValue {\n// Value exists, use unwrappedValue here\n} else {\n// Value doesn't exist\n}"),
        TestQuestionElement(type: .question(type: .oneChoice), question: "What is an optional variable in Swift?", answers: ["A variable that cannot be changed after initialization", "A variable that can hold either a value or no value", "A variable that automatically adjusts its type based on assigned values", "A variable that requires explicit declaration of its type"], correctAnswers: [1])
        
    ]
    
    
    // User's answers
    var answers : [[Int]] = []
    
    // Counter to know what lesson element we're displaying
    var counter = 0
    
    // A bit of info about the lesson, will be implemented in the future
    var lessonData : String = "Beginners lesson on Swift!!"
    
    // Current lesson element being displayed
    var currentElement : LessonElementViewController!
    
    
    // MARK: - View Controller Events
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tabBarController?.tabBar.isHidden = true
}
    
    
    // MARK: - Actions
    
    // This will start the lesson, it will take the user to the first lesson
    // element.
    // Maybe I should check if elementTypes is not empty
    @IBAction func start(_ sender: Any) {
        
        self.navigationController?.isNavigationBarHidden = true
        
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
        
        if self.counter == self.data.count {
            self.currentElement.viewWillDisappear(true)
            self.currentElement.willMove(toParent: nil)
            self.currentElement.dismiss(animated: false)
            self.navigationController?.isNavigationBarHidden = false
            self.tabBarController?.tabBar.isHidden = false
            self.navigationController?.popToRootViewController(animated: true)
            return
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
