//
//  HomePageViewController.swift
//  Swiftly
//
//  Created by Akın B on 3/10/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class HomePageViewController: UIViewController {
    
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var chapterOverview: UITableView!
    
    @IBOutlet weak var streakCount: UILabel!
    
    //    the fire logo
    @IBOutlet weak var streakLabel: UIImageView!
    @IBOutlet weak var leaderboardButton: UIButton!
    
    private let db = Firestore.firestore()
    
    override func viewWillAppear(_ animated: Bool) {
        Task {
            do {
                let currentUser = try await db.collection("users").document(Auth.auth().currentUser!.uid).getDocument(as: User.self)
                // Update UI or perform further actions based on the retrieved data
                userName.text = currentUser.userName
                
            } catch {
                print("Error fetching user data: \(error)")
                // Handle the error appropriately, e.g., display an alert to the user
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        let count:Int? = currentUser?.streakCount
//        streakCount.text = String(count)
        email.text = Auth.auth().currentUser?.email
        
        
//        Create DB

//        addChapter()
        
        
        
    }
    
    
    
    func addChapter(){
        var ch1 = Chapter()
        
        ch1.title = "Optional Variables"
        
        var tmpLessons: [Lesson] = []
        
        tmpLessons.append(Lesson(title: "What are Optionals?", content: "An optional in Swift is a type that represents a value that may or may not exist. It is denoted by adding a question mark (?) after the type declaration."))
        
        tmpLessons.append(Lesson(title: "Declaring Optionals", content: "To declare an optional, you simply append a question mark (?) to the type.", example: "var optionalInt: Int?\nvar optionalString: String?"))
        
        tmpLessons.append(Lesson(title: "Unwrapping Optionals", content: "To access the value inside an optional, you need to unwrap it. There are several ways to do this, including optional binding and forced unwrapping."))
        
        tmpLessons.append(Lesson(title: "Optional Binding", content: "Optional binding is a safe way to unwrap optionals. It uses if let or guard let syntax to conditionally unwrap the optional and assign its value to a constant or variable.",
                                example: "if let unwrappedValue = optionalValue {\n    // Value exists, use unwrappedValue here\n} else {\n    // Value doesn't exist\n}"))
        
        tmpLessons.append(Lesson(title: "Forced Unwrapping", content: "Forced unwrapping is another way to access the value inside an optional. It uses the exclamation mark (!) after the optional name.",
                                example: "let unwrappedValue = optionalValue!"))
        
        tmpLessons.append(Lesson(title: "Optional Chaining", content: "Optional chaining is a way to call methods, access properties, and subscript on an optional that might currently be nil. It is denoted by adding a question mark (?) after the optional value.", example: "let length = myOptionalString?.count\nIf myOptionalString is nil, the expression will return nil."))
        
        tmpLessons.append(Lesson(title: "Nil Coalescing Operator", content: "The nil coalescing operator (??) provides a default value when unwrapping an optional that is nil.", example: "let result = optionalValue ?? defaultValue\nIf optionalValue is nil, result will be set to defaultValue."))
        
        tmpLessons.append(Lesson(title: "Optional Types in Function Parameters", content: "You can make function parameters optional by adding a question mark (?) after the parameter type in the function definition.", example: "func greet(name: String?) {\n    if let name = name {\n        print(\"Hello, \\(name)!\")\n    } else {\n        print(\"Hello, stranger!\")\n    }\n}\nThis allows calling the function with or without passing a value for the parameter."))
        
        tmpLessons.append(Lesson(title: "Using Guard with Optionals", content: "The guard statement is used to unwrap optionals in functions and methods. It provides an early exit from a function if the optional is nil.", example: "func greet(name: String?) {\n    guard let name = name else {\n        print(\"Name is nil!\")\n        return\n    }\n    print(\"Hello, \\(name)!\")\n}\n\nThis ensures that the function continues execution only if the optional has a non-nil value."))
        
        tmpLessons.append(Lesson(title: "The \"if let\" vs \"guard let\"", content: "Both \"if let\" and \"guard let\" can be used to unwrap optionals, but they serve different purposes. \"if let\" is used when you want to conditionally execute code if the optional has a value. \"guard let\" is used when you want to exit early from a function or method if the optional is nil."))
        
        ch1.lessons = tmpLessons
        
        
        var tmpQuestions: [Question] = []
        
        tmpQuestions.append(Question(type: QuestionType.multipleChoice, questionString: "What is an optional variable in Swift?", options: ["A. A variable that cannot be changed after initialization", "B. A variable that can hold either a value or no value", "C. A variable that automatically adjusts its type based on assigned values", "D. A variable that requires explicit declaration of its type"], answer: [1]))
        
        tmpQuestions.append(Question(type: QuestionType.multipleChoice, questionString: "Which symbol is used to unwrap an optional variable safely in Swift?", options: ["A. !", "B. #", "C. ?", "D. ~"], answer: [2]))
        
        
        tmpQuestions.append(Question(type: QuestionType.multipleChoice, questionString: "What is the purpose of optional chaining in Swift?", options: ["A. To provide default values for optional variables","B. To safely access properties and methods of optional variables", "C. To convert optional variables to non-optional ones", "D. To force unwrap optional variables"], answer: [1]))
        
        tmpQuestions.append(Question(type: QuestionType.multipleChoice, questionString: "Which of the following statements is true about implicitly unwrapped optionals in Swift?", options: ["A. They must be initialized with a non-nil value", "B. They cannot be nil", "C. They require explicit unwrapping using the ! operator", "D. They automatically unwrap themselves when accessed"], answer: [0]))
        
        
        tmpQuestions.append(Question(type: QuestionType.multipleChoice, questionString: "What is the purpose of the guard let statement in Swift?", options: ["A. To safely unwrap an optional variable and provide a default value", "B. To force unwrap an optional variable and handle any resulting errors", "C. To create a new optional variable with an assigned value", "D. To check if an optional variable is nil and handle the case gracefully"], answer: [3]))
        
        
        tmpQuestions.append(Question(type: QuestionType.trueFalse, questionString: "Optionals in Swift represent values that may or may not be present.", options: ["True", "False"], answer: [0]))
        
        tmpQuestions.append(Question(type: QuestionType.trueFalse, questionString: "Forced unwrapping of an optional is safe and always returns a valid value.", options: ["True", "False"], answer: [1]))
        
        tmpQuestions.append(Question(type: QuestionType.trueFalse, questionString: " Implicitly unwrapped optionals in Swift are similar to regular optionals, but they automatically unwrap when accessed.", options: ["True", "False"], answer: [0]))
        
        tmpQuestions.append(Question(type: QuestionType.trueFalse, questionString: "Optionals can only be used with certain types like Int, String, and Double in Swift..", options: ["True", "False"], answer: [1]))
        
        tmpQuestions.append(Question(type: QuestionType.dragAndDrop, questionString: "   Rearrange the code snippets to create an optional variable `name` of type `String` that is initially set to `nil`, and then print its value if it exists.", options: ["var name: String?", "print(name)", "name = \"John\""], answer: [0,2,1]))
        
        ch1.questions = tmpQuestions
        
        
        let collectionRef = db.collection("chapters")
        do {
          let newDocReference = try collectionRef.addDocument(from: ch1)
          print("Book stored with new document reference: \(newDocReference)")
        }
        catch {
          print(error)
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LeaderboardSegue",
           let nextVC = segue.destination as? LeaderBoardViewController {
            let ds = [Person(name:"Tom", score: 300),
                      Person(name:"Charlie", score: 350),
                      Person(name:"Franklin", score: 100),
                      Person(name:"Alissa", score: 600),
                      Person(name:"Jane", score: 100),
                      
            ]
            let sortedArray = ds.sorted(by: { $0.score > $1.score })
            nextVC.ds = sortedArray
            
            
        }
        
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    }
}
