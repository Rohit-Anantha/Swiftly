//
//  ResultsElements.swift
//  Swiftly
//
//  Created by Guillermo Garcia Perez on 14/3/24.
//

import Foundation

class ResultsElement : LessonElement {
 
    // MARK: - Tst Variables
    
    // Protocol Variables
    let type: LessonElementTypes
    
    // Other Variables
    let tittle : String
    let message : String
    let results : [String]
    
    // MARK: - Tst Constructor
    
    init(type : LessonElementTypes, tittle : String, message : String, results : [String]){
        
        self.type = type
        
        self.tittle = tittle
        self.message = message
        self.results = results
    }
    
}
