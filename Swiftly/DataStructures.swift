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
    var totalScore:Int = 0
    var chapterScores:[Int]
}




struct Chapter: Codable{
    @DocumentID var id:String?
    
    var title:String
    
    var status: Completion
    
    var lessons: [Lesson]
    var questions: [Question]
    var answers: [Int]
    
    var pointsEarned:Int?
    
}


struct Lesson: Codable{
    
    var titles: [String]
    var content: [String]
    
//    Key = LessonIndex, Value = Code Example
    var examples: [Int : String]
    
}


struct Question: Codable{
    var type:QuestionType
    
    var questionString: String
    
    var options: [String]
    
//    Design Question
    var answer:Int?
    
}
