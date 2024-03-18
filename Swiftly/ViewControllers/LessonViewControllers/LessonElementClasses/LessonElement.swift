//
//  LessonElement.swift
//  Swiftly
//
//  Created by Guillermo Garcia Perez on 14/3/24.
//

import Foundation

protocol LessonElement {
    
    // MARK: - Documentation
    
    /*
     All classes used to contain the information related to each lesson element (i.e, each question, checkpoint
     result or lecture) will iherit from this class.
     
     The purpose of these classes is to be instanced with the data obtained from firebase (once that's implemented) and then
     passed on to the lessons' elements' view controllers so the right information can be displayed on screen.
     
     These clases can be found in the folder 'LessonElementClasses'
     */
    
    // MARK: - Variables
    
    var type : LessonElementTypes {get}
}
