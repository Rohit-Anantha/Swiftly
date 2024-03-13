//
//  DragAndDropViewController.swift
//  Swiftly
//
//  Created by Guillermo Garcia Perez on 9/3/24.
//

// View Controller for Lesson Questions with Drag and Drop style

import UIKit

class DragAndDropViewController: UIViewController, LessonElement {
    
    
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
        
        self.delegate = delegate
        
        // Set it up
    }
}
