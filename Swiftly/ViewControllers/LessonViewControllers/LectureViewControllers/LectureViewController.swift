//
//  LectureViewController.swift
//  Swiftly
//
//  Created by Guillermo Garcia Perez on 11/3/24.
//

import UIKit

class LectureViewController: UIViewController, LessonElementViewController {
    
    // MARK: - Documentation
    
    /*
     VC for lectures, not implemeted for now, only basics. In the future this will have a scrollable text view with the info and code snippets.
     User will be allowed to go back to roadmap from lectures. Won't be hard to implement.
     */
    
    
    // MARK: - Variables
    
    // Protocol Variables
    
    var delegate: LessonViewController!
    var number: Int!
    
    // Storyboard Variables
    @IBOutlet weak var lectureTitleLabel: UILabel!
    @IBOutlet weak var lectureTitleTextView: UITextView!
    
    // Other Variables
    var data : LectureElement!
    
    // MARK: - View Controller Events

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.lectureTitleLabel.text = self.data.title
        self.lectureTitleTextView.text = self.data.lecture
    }
    
    
    // MARK: - Actions
    
    @IBAction func startButton(_ sender: Any) {
        self.delegate.next(result: [])
    }
    
    
    // MARK: - Protocols
    
    func setup(data: LessonElement, delegate: LessonViewController, counter: Int) {
        self.delegate = delegate
        self.number = counter
        self.data = data as? LectureElement
    }
}
