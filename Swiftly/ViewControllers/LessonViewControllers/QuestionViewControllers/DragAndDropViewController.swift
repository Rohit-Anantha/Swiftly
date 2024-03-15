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
    
    // MARK: - Variables
    
    // Protocol Variables
    var delegate: LessonViewController!
    var number: Int!
    
    // Other Variables
    var data : DragAndDropElement!
    var hostingViewController : UIHostingController<DragAndDropSwiftUIView>!

    
    // MARK: - View Controller Events

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hostingViewController = UIHostingController(rootView: DragAndDropSwiftUIView(data: self.data))
        self.hostingViewController.modalPresentationStyle = .fullScreen
        present(self.hostingViewController, animated: true)
    }

    
    // MARK: - Actions

    
    // MARK: - Functions
    
    
    // MARK: - Protocols
    
    func setup(data: LessonElement, delegate: LessonViewController, counter: Int) {
        self.delegate = delegate
        self.number = counter
        self.data = data as? DragAndDropElement
    }
}
