//
//  RoadmapViewController.swift
//  Swiftly
//
//  Created by Eder Martinez on 3/15/24.
//

// TODO fix issues when in landscape.

import UIKit

class RoadmapViewController: UIViewController {
    // Amount of lessons
    private let circleCount = 10
    // Highest lesson for user
    private let currLesson = 1
    // Height (or width) of a circle
    private let circleDiameter = 125
    // Space between each circle
    private let paddingTop = 20
    
    // Custom class used only for giving UITapGestureRecognizer a property
    class CustomTapGestureRecognizer: UITapGestureRecognizer {
        var lessonNumber: Int = -1
    }
    
    @objc func imageTapped(sender: CustomTapGestureRecognizer) {
        // Gets the view controller from Lesson storyboard
        guard let vc = UIStoryboard(name: "Lesson", bundle: nil).instantiateViewController(identifier: "Lesson") as? LessonViewController else {
            return
        }
        
        // User has not unlocked these lessons
        if sender.lessonNumber > currLesson {
            let alert = UIAlertController(
                title: "Lesson Locked",
                message: "You are attempting to access a locked lesson. Please complete any previous lessons",
                preferredStyle: .alert)
            let cancel = UIAlertAction(
                title: "Cancel",
                style: .cancel)
            let nextLesson = UIAlertAction(
                title:"Next Lesson", style: .default) {_ in
                    // TODO pass any data here
                    self.navigationController!.pushViewController(vc, animated: true)
            }
            alert.addAction(cancel)
            alert.addAction(nextLesson)
            present(alert, animated: true)
        } else {
            // TODO pass any data here
            navigationController!.pushViewController(vc, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Your progress"
        
        let scroll = UIScrollView(frame: view.bounds)
        scroll.contentSize = CGSizeMake(view.frame.size.width, CGFloat(circleDiameter * circleCount + (paddingTop * (circleCount - 1))))
        scroll.backgroundColor = .lightGray
        
        view.addSubview(scroll)
        
        let parent = scroll
        
        
        var oldView: UIImageView?
        var constraints: [NSLayoutConstraint] = []

        
        for i in 0..<circleCount {
            
            let circle = UIImageView(image: UIImage(systemName: "circle.fill"))
            if i < currLesson{
                circle.tintColor = UIColor.green
            }
            if i == currLesson {
                circle.tintColor = UIColor.yellow
            }
            if i > currLesson{
                circle.tintColor = UIColor.red
            }
            circle.translatesAutoresizingMaskIntoConstraints = false
            
            // Action for UIImageView
            let tapGestureRecognizer = CustomTapGestureRecognizer(target: self, action: #selector(imageTapped))
            tapGestureRecognizer.lessonNumber = i
            
            circle.isUserInteractionEnabled = true
            circle.addGestureRecognizer(tapGestureRecognizer)
            
            constraints.append(circle.heightAnchor.constraint(equalToConstant: CGFloat(circleDiameter)))
            constraints.append(circle.widthAnchor.constraint(equalToConstant: CGFloat(circleDiameter)))
            
            // Top constraints
            if let oldView = oldView {
                // Add padding to top
                constraints.append(circle.topAnchor.constraint(equalTo: oldView.bottomAnchor, constant: CGFloat(paddingTop)))
            } else {
                constraints.append(circle.topAnchor.constraint(equalTo: parent.topAnchor))
            }
            
            // Horizontal constraints
            if i % 2 == 0 {
                constraints.append(circle.centerXAnchor.constraint(equalTo: parent.centerXAnchor))
            } else if i % 4 == 1 {
                constraints.append(circle.leadingAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.leadingAnchor))
            } else {
                constraints.append(circle.trailingAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.trailingAnchor))

            }
            oldView = circle
            
            parent.addSubview(circle)
        }
        NSLayoutConstraint.activate(constraints)
    }
}
