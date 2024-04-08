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
    
    
    var currentUser: User!
    override func viewWillAppear(_ animated: Bool){
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //        let count:Int? = currentUser?.streakCount
        //        streakCount.text = String(count)
        email.text = Auth.auth().currentUser?.email
        let dayInSeconds: TimeInterval = TimeInterval(60 * 60 * 24)
        
        Task{
            do {
                currentUser = try await db.collection("users").document(Auth.auth().currentUser!.uid).getDocument(as: User.self)
                // Update UI or perform further actions based on the retrieved data
                userName.text = currentUser.userName
                
                
                let userRef = db.collection("users").document(Auth.auth().currentUser!.uid)
                
                if(currentUser.lastLogIn - Date().timeIntervalSince1970 > dayInSeconds){
                    
                    currentUser.streakCount = 0
                }
                currentUser.streakCount = 1
                
                currentUser.lastLogIn = Date().timeIntervalSince1970
                
                do {
                    try userRef.setData(from: currentUser)
                }
                catch {
                    print(error)
                }
                
                streakCount.text = String(currentUser.streakCount)
                
                
                if(currentUser.streakCount < 3){
                    streakLabel.tintColor = .yellow
                    
                }else if(currentUser.streakCount > 3){
                    streakLabel.tintColor = .orange
                }
                
                
                
                
                
                
            } catch {
                print("Error fetching user data: \(error)")
                // Handle the error appropriately, e.g., display an alert to the user
            }
            
        }
        
        
        
        //        Create DB
                
        
        
    }
    
    
    
    func addChapter1(){
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
//            let newDocReference = try collectionRef.addDocument(from: ch1)
            let newDocReference = try collectionRef.document("\(ch1.title)").setData(from: ch1)
            print("Book stored with new document reference: \(newDocReference)")
        }
        catch {
            print(error)
        }
    }
    
    
    func addChapter2(){
        var ch2 = Chapter()
        
        ch2.title = "Type Safety"
        
        var tmpLessons: [Lesson] = []
        
        tmpLessons.append(Lesson(title: "Understanding Types", content: "In Swift, every variable and constant has a type, which defines the kind of value it can store.\nTypes include integers (like Int), floating-point numbers (like Double), strings (like String), and many others."))
        
        tmpLessons.append(Lesson(title: "Type Inference", content: "Swift uses type inference to automatically determine the type of variable or constant based on the initial value assigned to it.", example: "If you assign let number = 10, Swift infers that number is an Int."))
        
        tmpLessons.append(Lesson(title: "Type Annotations", content: "You can explicitly specify the type of variable or constant using type annotations.", example: " var age: Int = 25"))
        
        tmpLessons.append(Lesson(title: "Type Safety", content: "Swift is a type-safe language, meaning it helps you avoid accidentally mixing different types.You can't assign a value of one type to a variable of another type without explicit conversion or casting."))
        
        tmpLessons.append(Lesson(title: "Type Compatibility", content: "Swift checks for type compatibility during compilation to ensure that operations and assignments are performed with appropriate types.",example: "You can't add an Int to a String without converting one of them."))
        
        tmpLessons.append(Lesson(title: "Type Aliases", content: "You can create aliases for existing types using the typealias keyword.This is useful for making complex types more readable or for shortening lengthy type names.", example: "typealias Age = Int"))
        
        tmpLessons.append(Lesson(title: "Implicit Conversion", content: "Swift performs implicit conversions when it's safe and doesn't result in loss of data.", example: "You can assign an Int value to a Double variable without explicit conversion because it's safe."))
        
        tmpLessons.append(Lesson(title: "Explicit Conversion (Type Casting)", content: "When you need to convert a value from one type to another, you can use explicit conversion or type casting. Syntax: Type(value)", example: "let intValue = 5, let doubleValue = Double(intValue)"))
        
        tmpLessons.append(Lesson(title: "Handling Optionals", content: "Optionals are a special feature in Swift that represent the absence of a value.They help in handling cases where a value may be missing.Optionals must be unwrapped before using their value to ensure type safety."))
        
        tmpLessons.append(Lesson(title: "Type Inference and Functions", content: "Swift's type inference also works with functions, determining the types of parameters and return values based on their usage.You don't always need to specify the types of function parameters and return values explicitly."))
        
        ch2.lessons = tmpLessons
        
        
        var tmpQuestions: [Question] = []
        
        tmpQuestions.append(Question(type: QuestionType.multipleChoice, questionString: "What does \"type safety\" mean in Swift??", options: ["A. Ensuring that all variables have the same type", "B. Allowing variables to change their type dynamically", "C.Preventing errors by enforcing strict adherence to data types", "D.Ignoring data types altogether during compilation"], answer: [2]))
        
        tmpQuestions.append(Question(type: QuestionType.multipleChoice, questionString: "In Swift, each variable and constant must have a specific type known at:", options: ["A.  Runtime", "B. Initialization", "C. Compilation", "D. Execution"], answer: [1]))
        
        
        tmpQuestions.append(Question(type: QuestionType.multipleChoice, questionString: "Which statement about type safety and Objective-C interoperability in Swift is true?", options: ["A. Swift's type safety is compromised when interoperating with Objective-C code","B. Objective-C code can only be called from Swift if it follows Swift's strict type safety rules", "C. Swift provides seamless interoperability with Objective-C code without sacrificing type safety", "D. Type safety is irrelevant when working with Objective-C code in Swift"], answer: [2]))
        
        tmpQuestions.append(Question(type: QuestionType.multipleChoice, questionString: "Which Swift feature allows you to define custom data types with specific properties and methods?", options: ["A. Type inference", "B. Optionals", "C. Structs and classes", "D. Generics"], answer: [3]))
        
        
        
        tmpQuestions.append(Question(type: QuestionType.trueFalse, questionString: "Swift allows implicit type conversion between different data types without requiring explicit casting.", options: ["True", "False"], answer: [0]))
        
        tmpQuestions.append(Question(type: QuestionType.trueFalse, questionString: "In Swift, type safety means that once a variable is assigned a certain type, its type can be changed later.", options: ["True", "False"], answer: [1]))
        
        tmpQuestions.append(Question(type: QuestionType.trueFalse, questionString: " In Swift, it is possible to mix different types in arithmetic operations without causing any compile-time errors.", options: ["True", "False"], answer: [1]))
        
        tmpQuestions.append(Question(type: QuestionType.trueFalse, questionString: "Swift's type inference feature allows developers to omit explicit type declarations for variables and still maintain type safety.", options: ["True", "False"], answer: [0]))
        
        tmpQuestions.append(Question(type: QuestionType.trueFalse, questionString: "Optional types in Swift contribute to type safety by explicitly indicating the possibility of a value being absent.", options: ["True", "False"], answer: [0]))
        
        ch2.questions = tmpQuestions
        
        
        let collectionRef = db.collection("chapters")
        do {
//            let newDocReference = try collectionRef.addDocument(from: ch2)
            let newDocReference = try collectionRef.document("\(ch2.title)").setData(from: ch2)
            print("Book stored with new document reference: \(newDocReference)")
        }
        catch {
            print(error)
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LeaderboardSegue",
           let nextVC = segue.destination as? LeaderBoardViewController {
            
            // Query all documents from the "users" collection
            db.collection("users").getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    // Documents retrieved successfully
                    var users = [User]()
                    
                    // Iterate through each document in the querySnapshot
                    for document in querySnapshot!.documents {
                        do {
                            // Decode the document directly into a User object
                            let user = try document.data(as: User.self)
                            
                            print("leaderboard user: " + user.userName)
                            users.append(user)
                            
                        } catch let error {
                            print("Error decoding user: \(error)")
                        }
                    }
                    
                    // Sort the users array based on the .totalScore attribute
                    // Sort the users array based on the .totalScore attribute
                    users.sort { $0.totalScore > $1.totalScore }
                    
                    
                    nextVC.ds = users
                    
                    
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
    }
}
