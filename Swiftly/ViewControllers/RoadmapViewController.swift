//
//  RoadmapViewController.swift
//  Swiftly
//
//  Created by Eder Martinez on 3/2/24.
//

import UIKit
import SwiftUI

class RoadmapViewController: UIViewController {
    // Use ObservableObject to pass data that updates the view automatically
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let hostingController = UIHostingController(rootView: RoadmapNewView())
        hostingController.modalPresentationStyle = .fullScreen
        present(hostingController, animated: true)
    }
}
