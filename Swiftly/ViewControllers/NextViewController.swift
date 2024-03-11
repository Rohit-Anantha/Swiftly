//
//  NextViewController.swift
//  Swiftly
//
//  Created by Eder Martinez on 3/2/24.
//

import UIKit
import SwiftUI

struct NextRepresentedViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> LessonViewController {
        guard let viewController = UIStoryboard(name: "Lesson", bundle: nil).instantiateViewController(identifier: "lessonViewController") as? LessonViewController else {
            fatalError("LessonViewController not implemented in storyboard")
        }
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: LessonViewController, context: Context) {
        
    }
    
    typealias UIViewControllerType = LessonViewController
    
    
}
