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
    var timer = 0 // Lecture aren't times
    var stopTimer = true
    
    // Storyboard Variables
    @IBOutlet weak var lectureTitleLabel: UILabel!
    
    // Other Variables
    var data : LectureElement!
    
    // MARK: - View Controller Events

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let rtv = RoundedTextView()
        view.addSubview(rtv)
        rtv.constrain(width: 350, height: 500)
        rtv.isHidden = false
        
        NSLayoutConstraint.activate([
            // Center the RoundedTextView horizontally
            rtv.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            // Set the distance between the top of the view and the top of the RoundedTextView to 100 points
            rtv.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
        ])
        rtv.text = self.data.lecture
        rtv.sizeToFit()
        // Do any additional setup after loading the view.
        self.lectureTitleLabel.text = self.data.title

    }
    
    
    // MARK: - Actions
    
    @IBAction func startButton(_ sender: Any) {
        self.delegate.next(result: [], timer: -1)
    }
    
    
    // MARK: - Protocols
    
    func setup(data: LessonElement, delegate: LessonViewController, counter: Int, timer : Int) {
        self.delegate = delegate
        self.number = counter
        self.data = data as? LectureElement
    }
}
