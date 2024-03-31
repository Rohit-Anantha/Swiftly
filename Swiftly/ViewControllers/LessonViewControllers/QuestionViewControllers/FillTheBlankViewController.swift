//
//  FillTheBlankViewController.swift
//  Swiftly
//
//  Created by Guillermo Garcia Perez on 9/3/24.
//

// View Controller for Lesson Questions with Fill in the Blank style

import UIKit

class FillTheBlankViewController: UIViewController, LessonElementViewController {
    
    
    // MARK: - Documentation
    
    /*
     Eder did this VC in a another file, I didn't have enough time to do this myself. Thanks Eder! Idk how it works, we still have to integrate it.
     */
    
    
    // MARK: - Variables
    
    // Protocol Variables
    var delegate: LessonViewController!
    var number: Int!
    var timer = 0 //CHANGE
    var stopTimer = false //CHANGE
    
    // Storyboard variables
    
    // Other variables
    var data : FillTheBlankElement!
    
    
    // MARK: - View Controller Events

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    // MARK: - Actions

    
    
    // MARK: - Protocols
    
    func setup(data: LessonElement, delegate: LessonViewController, counter: Int, timer : Int) {
        self.delegate = delegate
        self.number = counter
        self.data = data as? FillTheBlankElement
    }
}
