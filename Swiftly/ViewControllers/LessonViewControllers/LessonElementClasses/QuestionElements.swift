//
//  QuestionElements.swift
//  Swiftly
//
//  Created by Guillermo Garcia Perez on 14/3/24.
//

import Foundation

class FillTheBlankElement : LessonElement {
    
    // MARK: - FTB Variables
    
    // Protocol Variables
    let type: LessonElementTypes
    
    // MARK: - FTB Constructor
    
    init(type : LessonElementTypes){
        self.type = type
    }
}

class DragAndDropElement : LessonElement {
    
    
    // MARK: - D&D Variables
    
    // Protcol Varibales
    let type: LessonElementTypes
    
    let question : [String]
    let options : [[String]]
    let correctOptions : [Int]
    
    
    // MARK: - D&D Constructor
    
    init(type : LessonElementTypes, question : [String], options : [[String]], correctOptions : [Int]){
        self.type = type
        
        self.question = question
        self.options = options
        self.correctOptions = correctOptions
    }
}

class TestQuestionElement : LessonElement {
 
    // MARK: - Tst Variables
    
    // Protocol Variables
    let type: LessonElementTypes
    
    // Other Variables
    let question : String
    let answers : [String]
    let correctAnswers : [Int]
    
    // MARK: - Tst Constructor
    
    init(type : LessonElementTypes, question : String, answers : [String], correctAnswers : [Int]){
        
        self.type = type
        
        self.question = question
        self.answers = answers
        self.correctAnswers = correctAnswers
    }
    
}
