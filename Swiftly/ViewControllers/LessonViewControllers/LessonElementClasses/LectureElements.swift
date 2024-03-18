//
//  LectureElements.swift
//  Swiftly
//
//  Created by Guillermo Garcia Perez on 14/3/24.
//

import Foundation

class LectureElement : LessonElement {
 
    // MARK: - Documentation

    /*
     These classes will contain the information of each lecture: title, text and possible code snippets
    */
    
    
    // MARK: - Variables
    
    // Protocol Variables
    let type: LessonElementTypes
    
    // Other Variables
    let title : String
    let lecture : String
    
    // MARK: - Constructor
    
    init(type : LessonElementTypes, title : String, lecture : String){
        
        self.type = type
        
        self.title = title
        self.lecture = lecture
    }
    
}
