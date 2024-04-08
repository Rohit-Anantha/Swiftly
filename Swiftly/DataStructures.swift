//
//  DataStructures.swift
//  Swiftly
//
//  Created by Guillermo Garcia Perez on 1/4/24.
//  Created by Akın B on 3/31/24.
//

import Foundation
import FirebaseFirestore


enum Completion: Int, Codable{
    case locked
    case inProgress
    case completed
    
}

enum QuestionType: Int, Codable {
    case dragAndDrop
    case multipleChoice
    case trueFalse
}


struct User: Codable{
    var userName: String
    var streakCount: Int = 0
    var currentLevel: Int = 0
    var totalScore: Double = 0
    var chapterScores:[Int]
    
    var lastLogIn: TimeInterval
}




struct Chapter: Codable{
    @DocumentID var id:String?
    
    var title:String
    
    var status: Completion
    
    var lessons: [Lesson]
    var questions: [Question]

    init(){
        title = ""
        status = Completion.locked
        lessons = []
        questions = []
    }
    
}


struct Lesson: Codable {
    
    var title: String
    var content: String
    
//    Key = LessonIndex, Value = Code Example
    var example: String?
    
}


struct Question: Codable{
    var type:QuestionType
    
    var questionString: String
    
    var options: [String]
    
//    Design Question
    var answer: [Int]
    
}
