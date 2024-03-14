//
//  LectureViewController.swift
//  Swiftly
//
//  Created by Guillermo Garcia Perez on 11/3/24.
//

import UIKit

class LectureViewController: UIViewController, LessonElement {
    

    // MARK: - Variables
    
    // Protocol Variables
    var delegate: LessonViewController!
    var number: Int!
    var data: [String]!
    
    // Storyboard Variables
    @IBOutlet weak var lectureTittleLabel: UILabel!
    @IBOutlet weak var lectureTittleTextView: UITextView!
    
    
    // MARK: - View Controller Events

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.lectureTittleLabel.text = self.data.first
        self.lectureTittleTextView.text = self.data[1]
    }
    
    
    // MARK: - Actions
    
    @IBAction func startButton(_ sender: Any) {
        self.delegate.next(result: [])
    }
    
    
    // MARK: - Protocols
    
    func setup(data: [String], delegate: LessonViewController, counter: Int, type: LessonElementTypes) {
        self.delegate = delegate
        self.number = counter
        self.data = data
    }
}
