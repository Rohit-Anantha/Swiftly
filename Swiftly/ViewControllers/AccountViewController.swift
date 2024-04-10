//
//  AccountViewController.swift
//  Swiftly
//
//  Created by Akın B on 3/15/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

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
        let controller = UIAlertController(
            title: "Change Username",
            message: "What do you want your new username to be?",
            preferredStyle: UIAlertController.Style.alert)
        controller.addTextField{(textField) in
            textField.placeholder = "New Username"
        }
        let attemptChange = UIAlertAction(title: "Change Username", style: .default){ (alertAction) in
            let username = controller.textFields![0].text
            let db = Firestore.firestore()
            Task {
                do {
                    var currentUser = try await db.collection("users").document(Auth.auth().currentUser!.uid).getDocument(as: User.self)
                    currentUser.userName = username!
                    try db.collection("users").document(Auth.auth().currentUser!.uid).setData(from: currentUser)
                } catch {
                    print("Error occured when changing username!")
                }
            }
            
        }
        controller.addAction(attemptChange)
        present(controller, animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func deleteAccountPressed(_ sender: Any) {
        let alert = UIAlertController(
            title: "Delete Account",
            message: "Are you sure you want to delete your account? This will permanently erase your account. All your date will be lost. This action is irreversible.",
            preferredStyle: .alert)
        let ok = UIAlertAction(
            title: "Delete",
            style: .destructive) { _ in
                // Erase data in firestore
                let userID = Auth.auth().currentUser!.uid
                let db = Firestore.firestore()
                db.collection("users").document(userID).delete() { error in
                    if let error = error {
                        print(error)
                    } else {
                        Auth.auth().currentUser!.delete() { _ in
                            self.performSegue(withIdentifier: "DeleteAccountSegue", sender: nil)
                        }
                    }
                }
                
            }
        let cancel = UIAlertAction(
            title: "Cancel",
            style: .cancel)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: false)
    }
}
