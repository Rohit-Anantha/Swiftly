//
//  LoginViewController.swift
//  Swiftly
//
//  Created by Akın B on 3/12/24.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil{
            print("\n\nalready logged in!!!!\n\n\n")
            self.performSegue(withIdentifier: "NoAnimationSegue", sender: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
    }
    
    @IBOutlet weak var usernameField: RoundedTextField!
    @IBOutlet weak var passwordField: RoundedTextField!
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func loginButtonPressed(_ sender: Any) {
        let email = usernameField.text!
        let password = passwordField.text!
        do{
            guard email != "" else{
                throw AuthenticationError.invalidEmail
            }
            
            guard password != "" && password.count > 7 else{
                throw AuthenticationError.passwordTooShort
            
            }
            Auth.auth().signIn(
                withEmail: email,
                password: password){ (user, error) in
                    
                    if let error = error as NSError? {
                        
                        print("Login failed")
                        
                    }else{
                        self.performSegue(withIdentifier: "LoggedInSegue", sender: nil)
                    }
                }
            /*
             Create Segue to home Page
             }
             */

            
        } catch {
            // Handle any other unexpected errors
            print("An unexpected error occurred: \(error.localizedDescription)")
        }
    }
    
}
