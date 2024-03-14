//
//  CheckpointElements.swift
//  Swiftly
//
//  Created by Guillermo Garcia Perez on 14/3/24.
//

import Foundation

class CheckpointElement : LessonElement {
 
    // MARK: - Tst Variables
    
    // Protocol Variables
    let type: LessonElementTypes
    
    // Other Variables
    let tittle : String
    let message : String
    
    // MARK: - Tst Constructor
    
    init(type : LessonElementTypes, tittle : String, message : String){
        
        self.type = type
        
        self.tittle = tittle
        self.message = message
    }
}
