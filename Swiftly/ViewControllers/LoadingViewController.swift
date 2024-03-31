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
    private var count: Int!
    private var innerCircleRadius: CGFloat!
    private var circleRadius: CGFloat!
    private var children: [UIView] = []
    private var color: UIColor!
    
    func setValues(count: Int, innerRadius: CGFloat, radius: CGFloat, color: UIColor) {
        self.count = count
        self.innerCircleRadius = innerRadius
        self.circleRadius = radius
        self.frame.size = CGSize(width: (innerRadius + radius) * 2, height: (innerRadius + radius) * 2)
        self.color = color
        createCircles()
    }
    
    private func createCircles() {
        for i in 0..<count {
            let circle = UIView()
            circle.frame.size = CGSize(width: circleRadius, height: circleRadius)
            circle.translatesAutoresizingMaskIntoConstraints = false
            circle.backgroundColor = color
            circle.frame.origin = getCircleOrigin(circleNumber: i)
            circle.layer.cornerRadius = circleRadius / 2
            circle.alpha = 0.0
            addSubview(circle)
            children.append(circle)
        }
    }
    
    private func getCircleOrigin(circleNumber i: Int) -> CGPoint {
        let viewMidPoint = center
        // Gets radian angle
        let angle = (Double(i * 2) / Double(count)) * CGFloat.pi
        let x = innerCircleRadius * cos(angle) + viewMidPoint.x
        let y = innerCircleRadius * sin(angle) + viewMidPoint.y
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
        label.font = UIFont.boldSystemFont(ofSize: CGFloat(20))
        label.sizeToFit()
        label.center = view.center
        view.addSubview(label)

        // Disables navigation
        navigationController!.isNavigationBarHidden = true
        tabBarController!.tabBar.isHidden = true
        
        let loadingSymbol = LoadingSymbolView()
        loadingSymbol.setValues(count: 30, innerRadius: CGFloat(150), radius: CGFloat(20), color: .accent)
        loadingSymbol.center = view.center
        loadingSymbol.enableAnimations()
        view.addSubview(loadingSymbol)
        Task {
            guard let vc = UIStoryboard(name: "Lesson", bundle: nil).instantiateViewController(identifier: "Lesson") as? LessonViewController else { return }
            usleep(2500000)
            do {
//                let snapshot = try await self.db.collection("lesson").document("\(lessonNumber!)").getDocument()
//                guard let allLessons = snapshot.value as? String else { throw ValueError.invalidType }
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
