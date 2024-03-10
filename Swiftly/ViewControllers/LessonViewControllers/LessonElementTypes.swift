//
//  LessonElementTypes.swift
//  Swiftly
//
//  Created by Guillermo Garcia Perez on 9/3/24.
//

import Foundation

/*
 This type strucutre will be used for creating lessons' elements
 
 Notes:
    - The rawType should be the same as the storyboard id of the according storyboard view
 */

enum LessonElementTypes {
    case question       (type : QuestionTypes)
    case lecture        (type : LectureTypes)
    case checkpoint     (type : CheckpointTypes)
    case results        (type : ResultsTypes)
}

enum QuestionTypes : String {
    case oneChoice      = "One Choice"
    case multipleChoice = "Multiple Choice"
    case trueOrFalse    = "True Or False"
    case fillTheBlank   = "Fill The Blank"
    case dragAndDrop    = "Drag And Drop"
}


enum LectureTypes : String {
    case lesson = "Lesson"       //For now just one type
}


enum CheckpointTypes : String {
    case checkpoint = "Checkpoint"   //For now just one type
}

enum ResultsTypes : String {
    case results = "Results"     //For now just one type
}
