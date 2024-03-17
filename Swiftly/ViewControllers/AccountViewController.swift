//
//  AccountViewController.swift
//  Swiftly
//
//  Created by Akın B on 3/15/24.
//

import UIKit
import FirebaseAuth

class AccountViewController: UIViewController {
    
    var password = ""
    
    @IBOutlet weak var newPasswordField: UITextField!
    @IBOutlet weak var confirmNewPassword: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = UIColor.white
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    @IBAction func saveChangesPressed(_ sender: Any) {
        let controller = UIAlertController(
            title: "Alert",
            message: "These features have not been implemented and only for display",
            preferredStyle: UIAlertController.Style.alert)
        
        controller.addTextField{(textField) in
        
            textField.placeholder = "Enter Email"
        }
        
        controller.addTextField{(textField) in
        
            textField.placeholder = "Enter Password"
        }
        
        
        let login = UIAlertAction(title: "Re-Login", style: .default) { (alertAction) in
            let username = controller.textFields![0] as UITextField
            let password = controller.textFields![1] as UITextField
            self.password = password.text!
            
            guard self.newPasswordField.text == self.confirmNewPassword.text else{
                
                print("Passwords Do Not Match!")
                return
            }
            self.reauthenticateAndUpdate(password: self.password)
            
            
        }
        controller.addAction(login)
        
        present(controller, animated: false)
        
        
        
    }
    func reauthenticateAndUpdate(password:String){
        
        let user = Auth.auth().currentUser
        let credential: AuthCredential  = EmailAuthProvider.credential(withEmail: user?.email ?? "", password: password)

        // Prompt the user to re-provide their sign-in credentials

        user?.reauthenticate(with: credential) { error, _  in
          if let error = error {
            // An error happened.
              print("Credential Error" + error.debugDescription)
          } else {
            // User re-authenticated.
              if(self.newPasswordField.text != ""){
                  Auth.auth().currentUser?.updatePassword(to: self.newPasswordField.text!)
                  
//                  RUNS WHEN SUCCEEDS?
//                  { (error) in
//                      print("Update Password Error: ")
//                  }
              }
              
//              if(Check username) and Update It!
              
              self.navigationController?.popViewController(animated: false)
          }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        


//        // Do any additional setup after loading the view.
//        let controller = UIAlertController(
//            title: "Alert",
//            message: "These features have not been implemented and only for display",
//            preferredStyle: .alert)
//
//        controller.addAction(UIAlertAction(title: "Go Back", style: .destructive){_ in
//            self.navigationController?.popViewController(animated: false)
//
//            })
//
//
//
//        controller.addAction(UIAlertAction(title: "OK!", style: .default){_ in
//
//        })
//
//        present(controller,animated: true)
        
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)

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
