//
//  AccountViewController.swift
//  Swiftly
//
//  Created by Akın B on 3/15/24.
//

import UIKit
import FirebaseAuth

/*
 MARK: - Account
 
This screen, the user will be able to change their username and password. it is accessed by pressing "Account" on the Settings tab.
 */

class AccountViewController: UIViewController {
    
    var password = ""
    
    @IBOutlet weak var textLabel: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = UIColor.white
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    func reauthenticateAndUpdate(password:String, email:String, newpassword:String){
        
        let user = Auth.auth().currentUser
        let credential: AuthCredential = EmailAuthProvider.credential(withEmail: (user?.email)!, password: password)
        print(credential)
        print(email, password, newpassword)
        user?.reauthenticate(with: credential){ error, _  in
            if let error = error {
                print(" error : " + error.description)
                user!.updatePassword(to: newpassword)
            }
            else {
                print("successfully reauth")
                user!.updatePassword(to: newpassword)
            }
        }
    }
    
    @IBAction func changePasswordPressed(_ sender: Any) {
        let controller = UIAlertController(
            title: "Change Password",
            message: "Please confirm your credentials",
            preferredStyle: UIAlertController.Style.alert)
        
        controller.addTextField{(textField) in
        
            textField.placeholder = "Enter Email"
        }
        
        controller.addTextField{(textField) in
        
            textField.placeholder = "Enter Current Password"
            textField.isSecureTextEntry = true
        }
        
        controller.addTextField{(textField) in
        
            textField.placeholder = "Enter New Password"
            textField.isSecureTextEntry = true
        }
        
        controller.addTextField{(textField) in
        
            textField.placeholder = "Reenter New Password"
            textField.isSecureTextEntry = true
        }
        
        
        let login = UIAlertAction(title: "Re-Login", style: .default) { (alertAction) in
            let email = controller.textFields![0].text
            let password = controller.textFields![1].text
            let newPassword = controller.textFields![2].text
            let confirmNewPassword = controller.textFields![3].text
            if newPassword != confirmNewPassword {
                self.textLabel.text = "New Passwords do not Match!"
            }
            self.reauthenticateAndUpdate(password: password!, email: email!, newpassword: newPassword!)
            
            
        }
        controller.addAction(login)
        
        present(controller, animated: false)
        
    }
    @IBAction func changeUsernamePressed(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
