//
//  LectureElements.swift
//  Swiftly
//
//  Created by Guillermo Garcia Perez on 14/3/24.
//

import Foundation

class LectureElement : LessonElement {
 
    // MARK: - Tst Variables
    
    // Protocol Variables
    let type: LessonElementTypes
    
    // Other Variables
    let tittle : String
    let lecture : String
    
    // MARK: - Tst Constructor
    
    init(type : LessonElementTypes, tittle : String, lecture : String){
        
        self.type = type
        
        self.tittle = tittle
        self.lecture = lecture
    }
    
}
