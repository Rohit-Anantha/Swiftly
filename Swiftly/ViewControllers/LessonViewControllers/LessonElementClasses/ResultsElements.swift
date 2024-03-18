//
//  ResultsElements.swift
//  Swiftly
//
//  Created by Guillermo Garcia Perez on 14/3/24.
//

import Foundation

class ResultsElement : LessonElement {
    
    // MARK: - Documentation

    /*
     These classes will contain the information of each results screen: what results to display and message or info
    */
 
    // MARK: - Variables
    
    // Protocol Variables
    let type: LessonElementTypes
    
    // Other Variables
    let tittle : String
    let message : String
    let results : [String]
    
    // MARK: - Constructor
    
    init(type : LessonElementTypes, tittle : String, message : String, results : [String]){
        
        self.type = type
        
        self.tittle = tittle
        self.message = message
        self.results = results
    }
    
}
