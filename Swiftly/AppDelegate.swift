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
        
        print("Loading theme " + (getSavedTheme()?.rawValue.description ?? "nil"))
        
        // Retrieve the saved theme from UserDefaults
        if let savedThemeRawValue = UserDefaults.standard.value(forKey: "swiftly_theme") as? Int,
           

           let savedTheme = UIUserInterfaceStyle(rawValue: savedThemeRawValue) {
            print("Setting to user saved theme")
            setTheme(savedTheme)
        } else {
            // If there is no saved theme or it's invalid, default to dark mode
            print("Setting to default theme")
            setTheme(.dark)
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
    
    func setTheme(_ theme: UIUserInterfaceStyle) {
        if #available(iOS 13.0, *) {
            print("Changed theme: " + theme.rawValue.description)
            UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = theme
            
            // Save the selected theme to user defaults
            UserDefaults.standard.set(theme.rawValue, forKey: "swiftly_theme")
            
        } else {
            // Fallback on earlier versions
            print("IOS version is lower than 13 and can't override theme")
        }
    }
    
    func getSavedTheme() -> UIUserInterfaceStyle? {
        if let savedTheme = UserDefaults.standard.value(forKey: "swiftly_theme") as? Int {
            return UIUserInterfaceStyle(rawValue: savedTheme)
        }
        return nil
    }


}

