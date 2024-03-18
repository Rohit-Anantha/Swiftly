//
//  LoginViewController.swift
//  Swiftly
//
//  Created by Akın B on 3/12/24.
//

import UIKit
import FirebaseAuth

/*
 MARK: - Login
 
 This is the initial screen to login into the app, it will auto call the segue if the user is already logged in.
 */
class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        Auth.auth().addStateDidChangeListener { auth, user in
            if(user != nil){
                self.performSegue(withIdentifier: "LoggedInSegue", sender: nil)
            }
        }
       
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
