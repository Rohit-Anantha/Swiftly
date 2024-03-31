//
//  QuestionElements.swift
//  Swiftly
//
//  Created by Guillermo Garcia Perez on 14/3/24.
//

import Foundation

// MARK: - Documentation

/*
 These classes will contain the information of each question type: the question, the possible answers, the correct answer... 
 Note: Fill in the blank is not implemented
 */

class FillTheBlankElement : LessonElement {
    
    // MARK: - FTB Variables
    
    // Protocol Variables
    let type: LessonElementTypes
    let isTimed : Bool
    let timer : Int
    
    // Other Variables
    var question: [(FillTheBlankViewType, String)]
    
    
    // MARK: - FTB Constructor
    
    init(type : LessonElementTypes, question: [(FillTheBlankViewType, String)], isTimed : Bool, timer : Int){
        self.type = type
        self.isTimed = isTimed
        self.timer = timer
        self.question = question
    }
    
    // MARK: - FTB Functions
    
    func getResults(_ results: [[Int]]) -> [[Int]] {
        return [[0]]
    }
}

class DragAndDropElement : LessonElement {
    
    
    // MARK: - D&D Variables
    
    // Protcol Varibales
    let type: LessonElementTypes
    
    // Other Variables
    let isTimed : Bool
    let timer : Int
    var question : [String]
    var options : [String]
    var correctAnswers : [Int]
    var numberAnswers : Int
    
    
    // MARK: - D&D Constructor
    

    init(type : LessonElementTypes, isTimed : Bool, timer : Int, question : [String], options : [String], correctOptions : [Int], number : Int){
        self.type = type
        self.isTimed = isTimed
        self.timer = timer
        self.question = question
        self.options = options
        self.correctAnswers = correctOptions
        self.numberAnswers = number
    }
}

class TestQuestionElement : LessonElement {
 
    // MARK: - Tst Variables
    
    // Protocol Variables
    let type: LessonElementTypes
    
    // Other Variables
    let isTimed : Bool
    let timer : Int
    let question : String
    let answers : [String]
    let correctAnswers : [Int]
    
    
    // MARK: - Tst Constructor
    
    init(type : LessonElementTypes, isTimed : Bool, timer : Int, question : String, answers : [String], correctAnswers : [Int]){
        
        self.type = type
        self.isTimed = isTimed
        self.timer = timer
        self.question = question
        self.answers = answers
        self.correctAnswers = correctAnswers
    }
     
    
    // MARK: - TsT Functions
    
    func getResults(_ results: [[Int]]) -> [[Int]] {
        return [[0]]
    }
}
