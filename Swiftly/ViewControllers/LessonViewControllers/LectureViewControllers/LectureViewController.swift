//
//  LectureViewController.swift
//  Swiftly
//
//  Created by Guillermo Garcia Perez on 11/3/24.
//

import UIKit

class LectureViewController: UIViewController, LessonElementViewController {
    
    
    // MARK: - Variables
    
    // Protocol Variables
    
    var delegate: LessonViewController!
    var number: Int!
    
    // Storyboard Variables
    @IBOutlet weak var lectureTittleLabel: UILabel!
    @IBOutlet weak var lectureTittleTextView: UITextView!
    
    // Other Variables
    var data : LectureElement!
    
    // MARK: - View Controller Events

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.lectureTittleLabel.text = self.data.tittle
        self.lectureTittleTextView.text = self.data.lecture
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
