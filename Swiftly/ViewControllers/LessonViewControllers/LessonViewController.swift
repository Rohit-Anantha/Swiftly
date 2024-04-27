//
//  LessonViewController.swift
//  Swiftly
//
//  Created by Guillermo Garcia Perez on 9/3/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

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
    var chapter: Chapter!
    
    @IBOutlet weak var lessonLabel: UILabel!
    var currentChapter = -1
    var data : [any LessonElement] = []
    
    // User's Answers
    var userAnswers : [[Int]] = []
    // User's Timer Results, for now we are storing here the time remaining:
    // the more time remainging the better the user did.
    // For now I'm also not storing the time taken per each question,
    // just the time it remaininf for a section of questions.
    var timerResults : [Int] = []
    
    // Counter to know what lesson element we're displaying
    var counter = 0
    
    // A bit of info about the lesson, will be implemented in the future
    var lessonData : String = "Beginners lesson on Swift!!"
    
    // Current lesson element being displayed
    var currentElement : LessonElementViewController!
    
    // Variables used to handle the question timers
    var wasPreviousTimed  = false
    var timer = -1
    var updateCircleCountDelegate: UpdateCircleCount!
    
    // Scalars for calculating score, for now they are static:
    // all lessons will have the same scoring scalars.
    static let pointsForCorrectAnswer = 5
    static let pointsForTimeRemaining = 0.1
    static let pointsSubtractedWrongAnswer = 8
    static let pointsSubtractedRunningOutTime = 20
    
    // Firestore for storing user's results
    let db = Firestore.firestore()
    
    // The user has completed or not
    var isReview: Bool!
    
    // Has the final screen with results been shown
    var finalResultsShown = false
    
    var userScore = 0
    var userDidPass = false

    
    // MARK: - View Controller Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // changing this varible changes whether it's the debug lesson or not.
        // Do any additional setup after loading the view.
        self.tabBarController?.tabBar.isHidden = true
        lessonLabel.text = "Lesson \(self.currentChapter + 1)"
        data = chapter.toLessonElementArray()
}
    
    
    // MARK: - Actions
    
    // This will start the lesson, it will take the user to the first lesson
    // element.
    // Maybe I should check if elementTypes is not empty
    @IBAction func start(_ sender: Any) {
        
        self.navigationController?.isNavigationBarHidden = true
        
        // Instantiate the next element
        self.currentElement = self.instantiateNextElement()
        
        // Set it up, the first element will never be a timed question,
        // so set the timer to -1.
        self.currentElement.setup(data: data.first!, delegate: self, counter: 0, timer: -1, isReview: isReview)
        
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
    func next(result : [Int], timer : Int) {
        
        self.timer = timer
        
        switch self.data[self.counter-1].type{
        case .question(type: _):
            self.userAnswers.append(result)
        default:
            break
        }
        
        if self.counter >= self.data.count {
            
            if !self.finalResultsShown {
                if !self.isReview {
                    self.calculateScore()
                    Task {await self.storeScore()}
                }
            } else {
                self.navigationController?.isNavigationBarHidden = false
                self.tabBarController?.tabBar.isHidden = false
                self.navigationController?.popToRootViewController(animated: true)
                return
            }
        }
        
        // This will be the next lesson element
        let next : LessonElementViewController
        if self.counter == self.data.count {
            next =  UIStoryboard(name: "Results", bundle: nil).instantiateViewController(identifier: "Results") as! ResultsViewController
            self.finalResultsShown = true
        }else{
            next = self.instantiateNextElement()
        }
        
        // Set it up and pass the according timer value
        if self.finalResultsShown {
            let message : String
            let score : Int
            if self.userDidPass {
                message = "Congragulations! You passed this lesson!"
                score = self.userScore
            } else {
                message = "Oh no! Seems like you failed more than 60% of the questions, you'll have to repeat this lesson!"
                score = 0
            }
            let resultsData = ResultsElement(type: .results(type: .final), title: "You finished this lesson!", message: message, results: ["Your score was \(score)"])
            next.setup(data: resultsData, delegate: self, counter: self.counter, timer: self.timer, isReview: isReview)
            if wasPreviousTimed {
                self.timerResults.append(self.timer)
            }
        } else {
            if wasPreviousTimed {
                // If the oprevious question was timed pass the current timer
                next.setup(data: self.data[counter], delegate: self, counter: self.counter, timer: self.timer, isReview: isReview)
                // If the timed question section has ended, add the time remaining to timerResults
                if !self.data[self.counter].isTimed {
                    self.timerResults.append(self.timer)
                    self.wasPreviousTimed = false
                }
            } else {
                if self.data[counter].isTimed {
                    // If the previous question wasn't timed check if this one should be
                    next.setup(data: self.data[counter], delegate: self, counter: self.counter, timer: self.data[counter].timer, isReview: isReview)
                    self.wasPreviousTimed = true
                } else {
                    // If it shouldn't be then pass -1 as a timer value
                    next.setup(data: self.data[counter], delegate: self, counter: self.counter, timer: -1, isReview: isReview)
                }
            }
        }
        
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
        
        if !self.finalResultsShown {
            counter+=1
        }
    }
    
    func decreaseScore() async {
        if self.isReview { return }
        
        // Get User
        let userName = Auth.auth().currentUser!.uid
        do {
            var currentUser : User = try await db.collection("users").document(userName).getDocument(as: User.self)
            
            let dbUser = db.collection("users").document(Auth.auth().currentUser!.uid)
            // Change user's stats, in this case decrease score if it's any lesson.
            currentUser.chapterScores.append(LessonViewController.pointsSubtractedRunningOutTime)
            currentUser.totalScore -= LessonViewController.pointsSubtractedRunningOutTime
            // Save user
            try dbUser.setData(from: currentUser)
            updateCircleCountDelegate.update(newCircle: currentUser.currentLevel)
        } catch {
            //Handle error
            print("error")
        }
    }
    
    func userRanOutOfTime(){
        
        // Maker the current question dissapear
        
        self.currentElement.willMove(toParent: nil)
        self.currentElement.view.removeFromSuperview()
        self.currentElement.removeFromParent()

        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.popToRootViewController(animated: true)
        return
    }
    
    
    // MARK: - Functions
    
    func showFinalResults(){
        
        
    }
    
    // Function for storing the user's results in Firestore after lesson ends. The results aren't computer before this
    // function, they are computed with computeResults()
    
    func storeScore() async {
        if self.userDidPass {
            // Get User
            let userName = Auth.auth().currentUser!.uid
            do {
                var currentUser : User = try await db.collection("users").document(userName).getDocument(as: User.self)
                
                let dbUser = db.collection("users").document(Auth.auth().currentUser!.uid)
                
                // Change user's stats only if they've completed their current lesson
                if self.currentChapter == currentUser.currentLevel{
                    currentUser.currentLevel += 1
                    currentUser.totalScore += self.userScore
                    if currentUser.chapterScores.count == currentUser.currentLevel {
                        currentUser.chapterScores[currentUser.currentLevel] += self.userScore
                    } else {
                        currentUser.chapterScores.append(self.userScore)
                    }
                    
                }
                
                // Save user
                try dbUser.setData(from: currentUser)
                updateCircleCountDelegate.update(newCircle: currentUser.currentLevel)
                
                
            } catch {
                //Handle error
                print("error")
            }
        }
    }
    
    
    // Computes results for the whole lesson
    
    func calculateScore() {
        
        // The user's score on this lesson
        var score = 0.0
        
        // Indices
        var dataIndex = 0
        
        // For question type checking
        var isFillInTheBlank = false
        var isMultipleChoiceTest = false
        
        // We will check if the percentage of correctly answered options
        // is greater than a certain amount percentage
        var totalOptions = 0
        var correctOptions = 0
        
        for item in self.userAnswers {
            
            // Score on this question
            var questionScore = 0
            
            ///     The Index for the questions in the 'data' variable
            var isQuestion = false
            while !isQuestion && dataIndex < self.data.count{
                switch self.data[dataIndex].type {
                    case .question(type: .fillTheBlank):
                        isQuestion = true
                        isFillInTheBlank = true
                    case .question(type: .multipleChoice):
                        isQuestion = true
                        isMultipleChoiceTest = true
                    case .question(type: _):
                        isQuestion = true
                        isFillInTheBlank = false
                    default:
                        dataIndex+=1
                }
            }
            if dataIndex >= self.data.count { break }
            
            ///     Here we fetch the correct answers to compare them to the user's reuslts
            let correctAnswers = (self.data[dataIndex] as! QuestionElement).correctAnswers
            
            ///     Here we compute the part of the score that the user recieves for correct answers
            if isFillInTheBlank {
                for response in correctAnswers {
                    if response == 1 {
                        questionScore += LessonViewController.pointsForCorrectAnswer
                        correctOptions+=1
                    }
                    totalOptions+=1
                }
            // This case is handled so that if the user answers all questions in a multiple choice test question he doesn't get
            // a good amount of points.
            } else if isMultipleChoiceTest {
                for (response,target) in zip(item, correctAnswers) {
                    if response == target {
                        questionScore += LessonViewController.pointsForCorrectAnswer
                        correctOptions+=1
                    } else {
                        questionScore -= LessonViewController.pointsSubtractedWrongAnswer
                    }
                    totalOptions+=1
                }
            } else {
                for (response,target) in zip(item, correctAnswers) {
                    if response == target {
                        questionScore += LessonViewController.pointsForCorrectAnswer
                        correctOptions+=1
                    }
                    totalOptions+=1
                }
            }
            
            score += CGFloat(questionScore)
            dataIndex += 1
        }
        
        ///     Here we add the part of the result the user get's for the time it took him to answer the timed questions
        for time in self.timerResults {
            score += Double(time) * LessonViewController.pointsForTimeRemaining
        }
        
        // Checking if the user has to repeat this lesson
        let userPassed = CGFloat(correctOptions)/CGFloat(totalOptions) > 0.6
        
        self.userScore = Int(round(score))
        self.userDidPass = userPassed
    }
    
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
            return FillTheBlankViewController()
            
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
