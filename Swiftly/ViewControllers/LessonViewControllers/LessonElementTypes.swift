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
    case oneChoice
    case multipleChoice
    case trueOrFalse
    case fillTheBlank
    case dragAndDrop
}


enum LectureTypes : String {
    case lecture        //For now just one type
}


enum CheckpointTypes : String {
    case checkpoint  //For now just one type
}

enum ResultsTypes : String {
    case intermediate     //For now just one type
    case final       //There are no more lesson elements after this
}
