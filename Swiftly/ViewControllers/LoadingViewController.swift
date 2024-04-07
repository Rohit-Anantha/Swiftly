//
//  LoadingViewController.swift
//  Swiftly
//
//  Created by Eder Martinez on 3/28/24.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class LoadingSymbolView: UIView {
    var count: Int!
    var innerCircleRadius: CGFloat!
    var circleRadius: CGFloat!
    var children: [UIView] = []
    var color: UIColor!
    
    func setValues(count: Int, innerRadius: CGFloat, radius: CGFloat, color: UIColor) {
        self.count = count
        self.innerCircleRadius = innerRadius
        self.circleRadius = radius
        self.frame.size = CGSize(width: (innerRadius + radius) * 2, height: (innerRadius + radius) * 2)
        self.color = color
        createCircles()
    }
    
    func setValues(count: Int, frame: CGRect, radius: CGFloat, color: UIColor) {
        self.count = count
        self.innerCircleRadius = frame.height / 2 - radius
        self.circleRadius = radius
        self.frame = frame
        self.color = color
        createCircles()
    }
    
    private func createCircles() {
        for i in 0..<count {
            let circle = UIView()
            circle.frame.size = CGSize(width: circleRadius * 2, height: circleRadius * 2)
            circle.translatesAutoresizingMaskIntoConstraints = false
            circle.backgroundColor = color
            circle.center = getCircleCenter(circleNumber: i)
            circle.layer.cornerRadius = circleRadius
            circle.alpha = 0.0
            addSubview(circle)
            children.append(circle)
        }
    }
    
    private func getCircleCenter(circleNumber i: Int) -> CGPoint {
        // Gets radian angle
        let angle = (Double(i * 2) / Double(count)) * CGFloat.pi
        let x = innerCircleRadius * cos(angle) + (frame.width / CGFloat(2))
        let y = innerCircleRadius * sin(angle) + (frame.width / CGFloat(2))
        let point = CGPoint(x: x, y: y)
        return CGPoint(x: x, y: y)
    }
    
    func enableAnimations(duration: Double = 0.5) {
//        for i in 0..<count {
//            children[i].alpha = CGFloat(i) / CGFloat(count)
//        }
        for i in 0..<count {
            let delay = Double(i) / Double(count) * duration
            UIView.animate(withDuration: duration, delay: delay, options: .repeat) {
                self.children[i].alpha = 1.0
            }
        }
    }
}

class LoadingViewController: UIViewController {
    private let db = Firestore.firestore()
    var lessonNumber: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .primaryTheme
        let label = UILabel()
        label.text = "Loading Questions"
        label.font = UIFont(name: "Avenir-Heavy", size: 25)
        label.sizeToFit()
        label.center = view.center
        view.addSubview(label)

        // Disables navigation
        navigationController!.isNavigationBarHidden = true
        tabBarController!.tabBar.isHidden = true
        
        let loadingSymbol = LoadingSymbolView()
        let newFrame = CGRect(origin: CGPoint(x: 0, y: view.center.y - view.frame.width / 2), size: CGSize(width: view.frame.width, height: view.frame.width))
        loadingSymbol.setValues(count: 25, frame: newFrame, radius: CGFloat(20), color: .accent)
        loadingSymbol.enableAnimations()
        view.addSubview(loadingSymbol)
        Task {
            guard let vc = UIStoryboard(name: "Lesson", bundle: nil).instantiateViewController(identifier: "Lesson") as? LessonViewController else { return }
            do {
                let snapshot = try await self.db.collection("chapters").getDocuments().documents[0]
                let chapter = try snapshot.data(as: Chapter.self)
                vc.chapter = chapter
                
                DispatchQueue.main.async {
                    self.navigationController!.pushViewController(vc, animated: true)
                }
            } catch {
                DispatchQueue.main.async {
                    self.navigationController!.popToRootViewController(animated: true)
                }
            }
        }
    }
}

enum ValueError: Error {
    case invalidType
}
