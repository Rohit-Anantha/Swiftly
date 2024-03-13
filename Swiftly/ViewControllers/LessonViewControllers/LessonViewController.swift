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
     (lectures, questions and checkpoints) information. The type for
     now is [[String]], we will need to change it in the future to some
     dictionary type structure. For now this variable will be populated
     with questions, in the future this variable should be assined a
     value to in the constructor.
     */
    var data : [[String]] = [
        // Lecture type
        /*["Introduction to Swift!",
            "Swift is a cool programing language..."],*/
        // One Choice question type
        ["What is an \"if else\" statement called?",
                "Conditional Banching",
                "Looping Construct",
                "Protocol",
                "Class"],
        // True or False question type
        ["Is Swift an interpreted language?"],
        // Multiple Choice question type
        ["Which of these keywords belong to swift?",
                "elif",
                "while",
                "protocol",
                "Class",
                "func",
                "ret"],
        // Fill in the Blank question type
        ["for i "," 1..10{\n",
                "(\"Hello, this is iteration \\(i)\")\n",
                "if i","5{\n",
                    "print(\"i=5!\")",
                "} "," {\n",
                    "print(\"i is not 5!\")",
                "}"],
        // Drag and Drop
        /*[...],
        // Results
        [...]
        */
    ]
    
    /*
     This variable will containe the type of the lesson elements
     */
    var elementTypes : [LessonElementTypes] = [
        LessonElementTypes.question(type: .oneChoice),
        LessonElementTypes.question(type: .trueOrFalse),
        LessonElementTypes.question(type: .multipleChoice),
        LessonElementTypes.question(type: .fillTheBlank),
    ]
    
    // User's answers
    var answers : [[Int]] = []
    
    // Counter to know what lesson element we're displaying
    var counter = 0
    
    // A bit of info about the lesson
    var lessonData : String = "Beginners lesson on Swift!!"
    
    // Current lesson element being displayed
    var currentElement : LessonElement!
    
    
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
        self.currentElement.setup(data: data.first!, delegate: self, counter: 0, type: elementTypes.first!)
        
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
        next.setup(data: self.data[counter], delegate: self, counter: self.counter, type: elementTypes[counter])
        
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
    func instantiateNextElement() -> LessonElement {
        
        var next : LessonElement!
        
        switch self.elementTypes[self.counter]{
            
        case .question(type: .oneChoice):
            next = UIStoryboard(name: "Test", bundle: nil).instantiateViewController(identifier: "Test") as? TestViewController
            
        case .question(type: .multipleChoice):
            next = UIStoryboard(name: "Test", bundle: nil).instantiateViewController(identifier: "Test") as? TestViewController
            
        case .question(type: .trueOrFalse):
            next = UIStoryboard(name: "Test", bundle: nil).instantiateViewController(identifier: "Test") as? TestViewController
            
        case .question(type: .fillTheBlank):
            next = UIStoryboard(name: "FillTheBlank", bundle: nil).instantiateViewController(identifier: "Fill The Blank") as? FillTheBlankViewController
            
        case .question(type: .dragAndDrop):
            next = UIStoryboard(name: "DragAndDrop", bundle: nil).instantiateViewController(identifier: "Drag And Drop") as? DragAndDropViewController
            
        case .lecture:
            next = UIStoryboard(name: "Lecture", bundle: nil).instantiateViewController(identifier: "LectureViewController") as? LectureViewController
            
        case .checkpoint:
            next = UIStoryboard(name: "CheckPoint", bundle: nil).instantiateViewController(identifier: "CheckpointViewController") as? CheckpointViewController

        case .results:
            next = UIStoryboard(name: "Results", bundle: nil).instantiateViewController(identifier: "ResultsViewController") as? ResultsViewController
            
        }
        
        return next
    }

}
