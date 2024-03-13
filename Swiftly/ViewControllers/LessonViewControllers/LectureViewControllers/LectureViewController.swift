//
//  LectureViewController.swift
//  Swiftly
//
//  Created by Guillermo Garcia Perez on 11/3/24.
//

import UIKit

class LectureViewController: UIViewController, LessonElement {
    

    // MARK: - Variables
    
    var delegate: LessonViewController!
    var number: Int!
    var data: [String]!
    
    
    
    // MARK: - View Controller Events

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - Actions
    
    
    
    // MARK: - Protocols
    
    func setup(data: [String], delegate: LessonViewController, counter: Int, type: LessonElementTypes) {
        return
    }
}
