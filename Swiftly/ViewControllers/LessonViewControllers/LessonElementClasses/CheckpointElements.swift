//
//  CheckpointElements.swift
//  Swiftly
//
//  Created by Guillermo Garcia Perez on 14/3/24.
//

import Foundation

class CheckpointElement : LessonElement {
 
    // MARK: - Documentation

    /*
     These classes will contain the information of each checkpoint: message to be displayed if user does good or bad,
     alert that next questions will be timed...
    */
    
    
    // MARK: - Variables
    
    // Protocol Variables
    let type: LessonElementTypes
    var isTimed = false
    var timer = -1
    
    // Other Variables
    let title : String
    let message : String
    
    // MARK: - Constructor
    
    init(type : LessonElementTypes, title : String, message : String){
        
        self.type = type
        
        self.title = title
        self.message = message
    }
}
