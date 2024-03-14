//
//  ResultsViewController.swift
//  Swiftly
//
//  Created by Guillermo Garcia Perez on 9/3/24.
//

import UIKit

class ResultsViewController: UIViewController, LessonElement {
    

    // MARK: - Variables
    
    // Protocol Variables
    var delegate: LessonViewController!
    var number: Int!
    var data: [String]!
    
    // Storyboard Variables
    @IBOutlet weak var checkpointTittleLabel: UILabel!
    @IBOutlet weak var checkpointTextView: UITextView!
    @IBOutlet weak var nextButton: UIButton!
    
    // Other variables
    var type : ResultsTypes!
    
    
    // MARK: - View Controller Events

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        switch self.type {
            case .final:
                self.nextButton.setTitle("Back to Roadmap", for: .normal)
            
            self.checkpointTittleLabel.text = "You're results are..."
            self.checkpointTextView.text = "Implement results... I don't know how to go back to roadmap, idk if it's swiftui or storyboard. If you want you can give me the code and I'll write i down. For now if you press the button you will get an error"
            
            case .intermediate:
                self.nextButton.setTitle("Keep Going", for: .normal)
            
                self.checkpointTittleLabel.text = "You're going great (?)"
                self.checkpointTittleLabel.text = "Implement intermediate checkpoint"
            default:
                print("Error, this shouldn't occur!")
        }
    }
    
    
    // MARK: - Actions
    
    @IBAction func nextButton(_ sender: Any) {
        self.delegate.next(result: [])
    }
    
    
    // MARK: - Protocols
    
    func setup(data: [String], delegate: LessonViewController, counter: Int, type: LessonElementTypes) {
        self.delegate = delegate
        self.data = data
        self.number = counter
        
        switch type{
            case .results(type: .intermediate):
                self.type = .intermediate
            case .results(type: .final):
                self.type = .final
            default:
                print("Error, this shouldn't happen!")
        }
    }
}
