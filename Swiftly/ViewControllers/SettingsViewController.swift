//
//  SettingsViewController.swift
//  Swiftly
//
//  Created by Akın B on 3/10/24.
//

import UIKit
import FirebaseAuth

let settings = [
"Account",
"App",
"Rate us",
"Sign out"
]

/*
// MARK: - Settings
This class represents the settings tab in the tab view controller. it holds a tableview for different content
 as well as sign out.
 */
class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsItemCell", for: indexPath)
        
        let row = indexPath.row
        cell.textLabel?.text = settings[row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let setting = settings[indexPath.row]
        
        switch setting {
        case "Account":
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let accountViewController = storyboard.instantiateViewController(withIdentifier: "accountID") as! AccountViewController

            
            
        
            navigationController?.pushViewController(accountViewController, animated: false)
            
            accountViewController.loadViewIfNeeded()


        case "App":
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let settingsVC = storyboard.instantiateViewController(withIdentifier: "settingsID") as! AppSettingsViewController

            
            
        
            navigationController?.pushViewController(settingsVC, animated: false)
            
            settingsVC.loadViewIfNeeded()
//        case "Language":break
//            showLanguageAlert()
        case "Rate us":break
//            showRateUsAlert()
        case "Sign out":
            showSignOutAlert()
        default:
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func showSignOutAlert() {
        let alertController = UIAlertController(title: "Sign Out", message: "Are you sure you want to sign out?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { _ in
            // Perform sign out action here
            do {
                try Auth.auth().signOut()
                // Sign-out successful.
                // You can perform any additional actions after sign-out here, like navigating to another view controller.
                self.performSegue(withIdentifier: "LoggedOutSegue", sender: nil)

    
                
            } catch let signOutError as NSError {
                print("Error signing out: %@", signOutError)
                // Handle sign-out errors if any.
            }
        }))
        present(alertController, animated: true, completion: nil)
    }


    @IBOutlet weak var settingsOverview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        settingsOverview.delegate = self
        settingsOverview.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarItem.title = "Settings"
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
