//
//  AppDelegate.swift
//  Swiftly
//
//  Created by Rohit Anantha on 2/28/24.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    var window: UIWindow?

    func application(_ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions:
                     [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        if Auth.auth().currentUser != nil {
            // User is already logged in, perform the segue to the home screen
            showHomeScreen()
        
        }

        
        Task {
          let center = UNUserNotificationCenter.current()
          try await center.requestAuthorization(options: [.badge, .sound, .alert])

          // 3
          await MainActor.run {
            application.registerForRemoteNotifications()
          }
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func showHomeScreen() {
        // Instantiate the home view controller from the main storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "TabBarViewController")

        // Set the root view controller of the window to the home view controller
        window?.rootViewController = homeViewController
        window?.makeKeyAndVisible()
    }



}

