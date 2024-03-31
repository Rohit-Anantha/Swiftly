//
//  RoadmapViewController.swift
//  Swiftly
//
//  Created by Eder Martinez on 3/15/24.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseDatabaseInternal

enum RoadmapError: Error {
    case NetworkFailed
    case TypeConversionFailure
}

class RoadmapViewController: UIViewController {
    
    let ref = Database.database().reference()
    // Amount of lessons
    private var circleCount: Int!
    // Highest lesson for user
    private var currLesson: Int!
    // Height (or width) of a circle
    private let circleDiameter = 125
    // Space between each circle
    private let paddingTop = 20
    // UIScrollView object
    private var scroll: UIScrollView!
    
    private var height: CGFloat!
    
    // Custom class used only for giving UITapGestureRecognizer a property
    class CustomTapGestureRecognizer: UITapGestureRecognizer {
        var lessonNumber: Int = -1
    }
    
    @objc func viewTapped(sender: CustomTapGestureRecognizer) {
        // Gets the view controller from Lesson storyboard
        let loadingVC = LoadingViewController()
        loadingVC.lessonNumber = sender.lessonNumber
        // User has not unlocked these lessons
        if sender.lessonNumber > currLesson {
            let alert = UIAlertController(
                title: "Lesson Locked",
                message: "You are attempting to access a locked lesson. Please complete any previous lessons.",
                preferredStyle: .alert)
            let cancel = UIAlertAction(
                title: "Cancel",
                style: .cancel)
            let nextLesson = UIAlertAction(
                title:"Next Lesson", style: .default) {_ in
                    self.navigationController!.pushViewController(loadingVC, animated: true)
            }
            alert.addAction(cancel)
            alert.addAction(nextLesson)
            present(alert, animated: true)
        } else {
            navigationController!.pushViewController(loadingVC, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Your progress"
        view.backgroundColor = .primaryTheme
        scroll = UIScrollView(frame: view.bounds)
        view.addSubview(scroll)
        let useNetwork = false
        if useNetwork {
            Task {
                do {
                    // Get total lessons here
                    let count = try await ref.child("lessonCount").getData()
                    guard let data = count.value as? Int else {
                        throw RoadmapError.TypeConversionFailure
                    }
                    circleCount = data
                    
                    // Get user currentLevel here
                    let current = try await ref.child("currentLesson").getData()
                    guard let currentData = current.value as? Int else {
                        throw RoadmapError.TypeConversionFailure
                    }
                    currLesson = currentData
                    
                    DispatchQueue.main.async {
                        self.addCircles()
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        } else {
            circleCount = 10
            currLesson = 1
            addCircles()
        }
    }
    
    func addCircles() {
        height = CGFloat((circleDiameter + paddingTop) * circleCount)
        
        var oldAnchor = scroll.topAnchor
        var constraints: [NSLayoutConstraint] = []
        for i in 0..<circleCount {
            // Initializes Circle View
            let dot = UIView()
            dot.layer.cornerRadius = CGFloat(circleDiameter) / CGFloat(2)
            dot.backgroundColor = i < currLesson ? .green : i > currLesson ? .red : .yellow
//            dot.backgroundColor = .accent
            dot.translatesAutoresizingMaskIntoConstraints = false
            
            // Initializes Label
            let label = UILabel()
            label.text = "Optionals"
            label.sizeToFit()
            label.translatesAutoresizingMaskIntoConstraints = false
            height += label.frame.height

            
            // Action for UIView
            let tapGestureRecognizer = CustomTapGestureRecognizer(target: self, action: #selector(viewTapped))
            tapGestureRecognizer.lessonNumber = i
            dot.isUserInteractionEnabled = true
            dot.addGestureRecognizer(tapGestureRecognizer)
            
            constraints.append(dot.heightAnchor.constraint(equalToConstant: CGFloat(circleDiameter)))
            constraints.append(dot.widthAnchor.constraint(equalToConstant: CGFloat(circleDiameter)))
            
            // Top constraints
            constraints.append(label.topAnchor.constraint(equalTo: oldAnchor, constant: CGFloat(paddingTop)))
            constraints.append(dot.topAnchor.constraint(equalTo: label.bottomAnchor))

            
            // Horizontal constraints
            if i % 2 == 0 {
                constraints.append(dot.centerXAnchor.constraint(equalTo: scroll.centerXAnchor))
                constraints.append(label.centerXAnchor.constraint(equalTo: dot.centerXAnchor))
            } else if i % 4 == 1 {
                constraints.append(dot.leadingAnchor.constraint(equalTo: scroll.safeAreaLayoutGuide.leadingAnchor, constant: CGFloat(paddingTop)))
                constraints.append(label.leadingAnchor.constraint(equalTo: dot.leadingAnchor))
            } else {
                constraints.append(dot.trailingAnchor.constraint(equalTo: scroll.safeAreaLayoutGuide.trailingAnchor, constant: CGFloat(-paddingTop)))
                constraints.append(label.trailingAnchor.constraint(equalTo: dot.trailingAnchor))
            }
            oldAnchor = dot.bottomAnchor
            scroll.addSubview(dot)
            scroll.addSubview(label)
        }
        NSLayoutConstraint.activate(constraints)
        scroll.contentSize = CGSizeMake(scroll.frame.width, height)
  }
    
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        // can set without first being initialized
        guard let scroll = scroll else { return }
        scroll.contentSize.width = size.width
        scroll.frame.size = size
    }
}
