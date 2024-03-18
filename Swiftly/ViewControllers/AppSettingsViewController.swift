//
//  AppSettingsViewController.swift
//  Swiftly
//
//  Created by Akın B on 3/15/24.
//

import UIKit


/*
 MARK: - App Settnigs
 
Here the user will be able to customize their app from changing the language to changing the theme. NOT IMPLEMENTED. Accessed via "App" on Settings tab.
 */
class AppSettingsViewController: UIViewController {
    
    var password = ""
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = UIColor.white
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Do any additional setup after loading the view.
        let alert = UIAlertController(
            title: "Alert",
            message: "These features have not been implemented and only for display",
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Go Back", style: .destructive){_ in
            self.navigationController?.popViewController(animated: false)
                
            })

        
        
            

        present(alert,animated: true)
        
        
        
        
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
