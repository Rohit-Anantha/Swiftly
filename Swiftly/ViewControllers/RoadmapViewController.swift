//
//  RoadmapViewController.swift
//  Swiftly
//
//  Created by Eder Martinez on 3/15/24.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class RoadmapViewController: UIViewController {
    
    let db = Firestore.firestore()
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
        if let font = UIFont(name: "Avenir-Book", size: 17) {
                navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font]
            }
        if let font = UIFont(name: "Avenir-Book", size: 17) {
                UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
            }
        view.backgroundColor = .primaryTheme
        scroll = UIScrollView(frame: view.bounds)
        scroll.backgroundColor = .lightGray
        view.addSubview(scroll)
        Task {
            do {
                // Get total lessons here
                let metadata = try await db.collection("lessons").document("metadata").getDocument()
                circleCount = metadata.data()!["count"] as? Int
                
                // Get user currentLevel here
                let userID = Auth.auth().currentUser!.uid
                let user = try await db.collection("users").document(userID).getDocument()
                currLesson = user.data()!["currentLevel"] as? Int
                
                DispatchQueue.main.async {
                    self.addCircles()
                }
            } catch {
                print(error.localizedDescription)
            }
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
            dot.layer.shadowColor = UIColor.black.cgColor
            dot.clipsToBounds = false
            dot.layer.shadowOpacity = 0.5
            dot.layer.shadowOffset = CGSizeMake(10, 10)
            dot.layer.shadowRadius = 10
            
            // Initializes Label
            let label = UILabel()
            label.text = "Optionals"
            label.sizeToFit()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont(name:"Avenir-Book", size:17)
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
                constraints.append(label.centerXAnchor.constraint(equalTo: dot.centerXAnchor))
            } else {
                constraints.append(dot.trailingAnchor.constraint(equalTo: scroll.safeAreaLayoutGuide.trailingAnchor, constant: CGFloat(-paddingTop)))
                constraints.append(label.centerXAnchor.constraint(equalTo: dot.centerXAnchor))
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
        scroll.contentSize.width = size.width
        scroll.frame.size = size
    }
}
