//
//  TabBarViewController.swift
//  Swiftly
//

//  Created by Akın B on 3/6/24.
//

import UIKit
import SwiftUI
import FirebaseFirestore


private let db = Firestore.firestore()

class CustomTabBarController: UITabBarController {
    
    private let homeVCID = "HomePageViewController"
    private let settingsVCID = "SettingsViewController"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let roadmapVC = RoadmapViewController()
        roadmapVC.title = "Your Progress"

        guard let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: homeVCID) as? HomePageViewController else {
            fatalError("HomePageViewController not implemented in storyboard")
        }
        
        guard let settingsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: settingsVCID) as? SettingsViewController else {
            fatalError("SettingsViewController not implemented in storyboard")
        }
        
        let roadmapNav = UINavigationController(rootViewController: roadmapVC)
        let homeNav = UINavigationController(rootViewController: homeVC)
        let settingsNav = UINavigationController(rootViewController: settingsVC)
        
        roadmapNav.title = "Roadmap"
        homeNav.title = "Home"
        settingsNav.title = "Settings"
        
        
        setViewControllers([roadmapNav, homeNav, settingsNav], animated: false)
        
        guard let items = tabBar.items else {
            return
        }
        
        items[0].image = UIImage(systemName: "swift")
        items[1].image = UIImage(systemName: "homekit")
        items[2].image = UIImage(systemName: "gearshape")
        
        modalPresentationStyle = .fullScreen
        
        // Sets home as initial screen
        selectedIndex = 1
        

        // Do any additional setup after loading the view.
//        
//        // Create three view controllers for each tab
//        let codeViewController = UIViewController()
//        codeViewController.view.backgroundColor = .blue
//        codeViewController.tabBarItem = UITabBarItem(title: "Code", image: UIImage(systemName: "1.circle"), tag: 0)
//
//        let homeViewController = UIViewController()
//        homeViewController.view.backgroundColor = .green
//        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "2.circle"), tag: 1)
//
//        let settingsViewController = UIViewController()
//        settingsViewController.view.backgroundColor = .orange
//        settingsViewController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "3.circle"), tag: 2)
//
//        // Set the view controllers for the tabs
//        self.viewControllers = [codeViewController, homeViewController, settingsViewController]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
