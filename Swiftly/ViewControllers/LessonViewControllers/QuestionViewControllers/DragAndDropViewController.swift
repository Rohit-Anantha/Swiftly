//
//  DragAndDropViewController.swift
//  Swiftly
//
//  Created by Guillermo Garcia Perez on 9/3/24.
//

// View Controller for Lesson Questions with Drag and Drop style

import UIKit
import SwiftUI

class DragAndDropViewController: UIViewController, LessonElementViewController{
    
    
    // MARK: - Documentation
    
    /*
     VC for drag and drop question type. Coding this in stoyboard seemed awfull so I did it in SwiftUI. This VC presents a UIHostingViewController,
     a VC meant for displaying swiftUI views.
     
     It acts as a middle man and gives some parameters to SwiftUI, the reason all the functionality is not done in SwiftUI is because I'm not familiar
     with SwiftUI!
     
     When the SwiftUI view is dismissed, this is the VC that does it. SiftUI does not call LessonViewController's 'next' function, it calls this VC's
     'next' function.
     */
    
    
    // MARK: - Variables
    
    // Protocol Variables
    var delegate: LessonViewController!
    var number: Int!
    var timer = 0
    var stopTimer = false // This will not be used but we needed to conform to protocol

    
    // Other Variables
    var data : DragAndDropElement!
    var hostingViewController : UIHostingController<DragAndDropSwiftUIView>!

    
    // MARK: - View Controller Events

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var answerList : [String] = []
        for i in 1...self.data.numberAnswers {
            answerList.append("\(i). __")
        }
        
        self.hostingViewController = UIHostingController(rootView: DragAndDropSwiftUIView(delegate: self, data: self.data, answers: answerList, options: self.data.options, timer: self.timer, isTimed: data.isTimed))
        self.hostingViewController.modalPresentationStyle = .fullScreen
        present(self.hostingViewController, animated: true)
    }

    
    // MARK: - Actions

    
    // MARK: - Functions
    
    func next(userAnswers : [Int], timer : Int){
        self.hostingViewController.dismiss(animated: true)
        self.delegate.next(result: [0], timer: timer)
    }
    
    // MARK: - Protocols
    
    func setup(data: LessonElement, delegate: LessonViewController, counter: Int, timer : Int) {
        self.delegate = delegate
        self.number = counter
        self.data = data as? DragAndDropElement
        self.timer = timer
    }
}
