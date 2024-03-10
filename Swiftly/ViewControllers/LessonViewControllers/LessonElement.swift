//
//  LessonElement.swift
//  Swiftly
//
//  Created by Guillermo Garcia Perez on 9/3/24.
//

import Foundation
import UIKit

protocol LessonElement : UIViewController {
    
    var delegate : LessonViewController! {get set}
    
    //In the future thr object we will have to pass will probably be a list of strings
    func setup(data : [String], delegate : LessonViewController, counter : Int)
}
