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
    
    var numId: Int = -1
    
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
            lessonElements.append(lesson.toLectureElement())
        }
        
        lessonElements.append(CheckpointElement(type: .checkpoint(type: .checkpoint), title: "Keep up the good work!", message: "Time to put what you learned into practice with some questions. Good luck!"))
        
        for question in questions {
            lessonElements.append(question.toQuestionElement())
        }
        return lessonElements
    }
    
}


/// A Lesson (similar to Lecture) that simply displays a title and information.
struct Lesson: Codable {
    
    var title: String
    var content: String
    
//    Key = LessonIndex, Value = Code Example
    var example: String?
    
    /// Converts the Lesson to a LectureElement, its equivalent in Swiftly
    /// - Returns: A Lecture Element
    func toLectureElement() -> LectureElement{
        return LectureElement(type: .lecture(type: .lecture), title: title, lecture: content, example: example ?? "")
    }
}


/// Description
///
/// A Question that can be a few different types.
struct Question: Codable{
    var type:QuestionType
    
    var questionString: String
    
    var options: [String]
    
    var time: Int = 0
    
//    Design Question
    var answer: [Int]
    
    /// Converts a Question to a Lesson Element depending on the type of Question, in order to display in Swiftly
    /// - Returns: A LessonElement version of the Question
    func toQuestionElement() -> LessonElement{
        switch type{
        case QuestionType.multipleChoice :
            return TestQuestionElement(type: .question(type: .multipleChoice), isTimed: time == 0 ? false : true, timer: time, question: questionString, answers: options, correctAnswers: answer)
        case QuestionType.trueFalse :
            return TestQuestionElement(type: .question(type: .trueOrFalse), isTimed: time == 0 ? false : true, timer: time, question: questionString, answers: options, correctAnswers: answer)
        case QuestionType.dragAndDrop :
            return DragAndDropElement(type: .question(type: .dragAndDrop), isTimed: time == 0 ? false : true, timer: time, question: [questionString], options: options, correctOptions: answer, number: answer.count)
        }
    }
}
