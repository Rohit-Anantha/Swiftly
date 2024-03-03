//
//  NextViewController.swift
//  Swiftly
//
//  Created by Eder Martinez on 3/2/24.
//

import UIKit
import SwiftUI

class NextViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

struct NextRepresentedViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> NextViewController {
        guard let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "nextViewController") as? NextViewController else {
            fatalError("ViewController not implemented in storyboard")
        }
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: NextViewController, context: Context) {
        
    }
    
    typealias UIViewControllerType = NextViewController
    
    
}
