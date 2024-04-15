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
    
    func toLessonElementArray() -> [LessonElement]{
        var lessonElements : [LessonElement] =  []
        for lesson in lessons{
            lessonElements.append(lesson.toLessonElement())
        }
        
        for question in questions {
            lessonElements.append(question.toQuestionElement())
        }
        return lessonElements
    }
    
}


struct Lesson: Codable {
    
    var title: String
    var content: String
    
//    Key = LessonIndex, Value = Code Example
    var example: String?
    func toLessonElement() -> LectureElement{
        return LectureElement(type: .lecture(type: .lecture), title: title, lecture: content)
    }
}


struct Question: Codable{
    var type:QuestionType
    
    var questionString: String
    
    var options: [String]
    
//    Design Question
    var answer: [Int]
    func toQuestionElement() -> LessonElement{
        switch type{
        case QuestionType.multipleChoice :
            return TestQuestionElement(type: .question(type: .multipleChoice), isTimed: false, timer: 0, question: questionString, answers: options, correctAnswers: answer)
        case QuestionType.trueFalse :
            return TestQuestionElement(type: .question(type: .trueOrFalse), isTimed: false, timer: 0, question: questionString, answers: options, correctAnswers: answer)
        case QuestionType.dragAndDrop :
            return DragAndDropElement(type: .question(type: .dragAndDrop), isTimed: false, timer: 0, question: [questionString], options: options, correctOptions: answer, number: answer.count)
        default :
            return CheckpointElement(type: .checkpoint(type: .checkpoint), title: "Load Error", message: "Load Error")
        }
    }
}
