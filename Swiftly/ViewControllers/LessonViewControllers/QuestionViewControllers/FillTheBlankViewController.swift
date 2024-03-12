//
//  FillTheBlankViewController.swift
//  Swiftly
//
//  Created by Guillermo Garcia Perez on 9/3/24.
//

// View Controller for Lesson Questions with Fill in the Blank style

import UIKit

class FillTheBlankViewController: UIViewController, LessonElement {
    
    
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
    
    func setup(data: [String], delegate: LessonViewController, counter: Int) {
        
        self.delegate = delegate
        
        // Set it up
    }
}
