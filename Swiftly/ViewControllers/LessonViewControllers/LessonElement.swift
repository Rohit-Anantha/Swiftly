//
//  LessonElement.swift
//  Swiftly
//
//  Created by Guillermo Garcia Perez on 9/3/24.
//

import Foundation
import UIKit

protocol LessonElement : UIViewController {
    
    // MARK: - Documentation
    
    /*/
     A lesson element will be anything showed within a lesson: checkpoint, result screen,
     question, or small lecture.
     
     All these elements will inherit from this class.
     */
    
    // MARK: - Variables
    
    // The Lesson View Controller that presented the lesson element
    var delegate : LessonViewController! {get set}
    // The number of the question (for example 3 if it's the third Lesson element)
    var number : Int! {get set}
    // The lesson element's data
    var data : [String]! {get set}
    
    
    // MARK: - Functions
    
    // This function will be used to setup the data variable of each lesson element to
    // it's correspondig value. This 'data' variable would containt, for example:
    // the question, an image or text corresponding to a snippet of code, all the
    // possible answers, some color configuration if needed.
    // In the future it will ne fetched from Firebase and it'll be some dictionary or
    // JSON type object.
    func setup(data : [String], delegate : LessonViewController, counter : Int, type : LessonElementTypes)
}
