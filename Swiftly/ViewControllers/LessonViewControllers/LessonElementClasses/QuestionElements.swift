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
    
    // Other Variables
<<<<<<< HEAD
    var question: [(FillTheBlankViewType, String)]
    
    // MARK: - FTB Constructor
    init(type: LessonElementTypes, question: [(FillTheBlankViewType, String)]) {
        self.type = type
        self.question = question
=======
    let isTimed : Bool
    
    // MARK: - FTB Constructor
    
    init(type : LessonElementTypes, isTimed : Bool){
        self.type = type
        self.isTimed = isTimed
    }
    
    // MARK: - FTB Functions
    
    func getResults(_ results: [[Int]]) -> [[Int]] {
        return [[0]]
>>>>>>> d700cf2 (results)
    }
}

class DragAndDropElement : LessonElement {
    
    
    // MARK: - D&D Variables
    
    // Protcol Varibales
    let type: LessonElementTypes
    
    // Other Variables
    let isTimed : Bool
    var question : [String]
    var options : [String]
    var correctAnswers : [Int]
    var numberAnswers : Int
    
    
    // MARK: - D&D Constructor
    
    init(type : LessonElementTypes, isTimed : Bool, question : [String], options : [String], correctOptions : [Int], number : Int){
        self.type = type
        self.isTimed = isTimed
        self.question = question
        self.options = options
        self.correctAnswers = correctOptions
        self.numberAnswers = number
    }
    
    // MARK: - D&D Functions
    
    func getResults(_ results: [[Int]]) -> [[Int]] {
        return [[0]]
    }
}

class TestQuestionElement : LessonElement {
 
    // MARK: - Tst Variables
    
    // Protocol Variables
    let type: LessonElementTypes
    
    // Other Variables
    let isTimed : Bool
    let question : String
    let answers : [String]
    let correctAnswers : [Int]
    
    
    // MARK: - Tst Constructor
    
    init(type : LessonElementTypes, isTimed : Bool, question : String, answers : [String], correctAnswers : [Int]){
        
        self.type = type
        self.isTimed = isTimed
        self.question = question
        self.answers = answers
        self.correctAnswers = correctAnswers
    }
     
    
    // MARK: - TsT Functions
    
    func getResults(_ results: [[Int]]) -> [[Int]] {
        return [[0]]
    }
}
