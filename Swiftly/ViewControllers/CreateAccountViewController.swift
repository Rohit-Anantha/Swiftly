//
//  CreateAccountViewController.swift
//  Swiftly
//
//  Created by Akın B on 3/9/24.
//

import UIKit
import FirebaseAuth

enum AuthenticationError: Error {
    case invalidEmail
    case passwordsDoNotMatch
    case passwordTooShort
}

/*
 MARK: - Create Account
 
 Screen for users that are creating an account. Accessed via the "Create Account" button on the Login Page
 */
class CreateAccountViewController: UIViewController {
    
    
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    var email: String = ""
    var userName: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    
    @IBAction func finishedEditing(_ sender: UITextField) {
        email = sender.text!
        
    }
    
    @IBAction func filledUsername(_ sender: UITextField) {
        userName = sender.text!
    }
    
    
    @IBAction func filledPassword(_ sender: UITextField) {
        password = sender.text!
    }
    
    
    @IBAction func filledConfirmPassword(_ sender: UITextField) {
        confirmPassword = sender.text!
    }
    
    @IBAction func tryCreateAccount(_ sender: UIButton) {
        
        do {
            guard isValidEmail(email) else {
                throw AuthenticationError.invalidEmail
            }
            
            guard password == confirmPassword else {
                throw AuthenticationError.passwordsDoNotMatch
            }
            
            guard password.count > 7 else {
                throw AuthenticationError.passwordTooShort
            }
            
            // Code to register the user if all validations pass
            
        } catch let error as AuthenticationError {
            handleAuthenticationError(error)
        } catch {
            // Handle any other unexpected errors
            print("An unexpected error occurred: \(error.localizedDescription)")
        }
        
        Auth.auth().createUser(
            withEmail: email,
            password: password) { user, error in
                if error == nil {
                    Auth.auth().signIn(
                        withEmail: self.email,
                        password: self.password)
                    /*
                     Create Segue to home Page
                     }
                     */
                    self.performSegue(withIdentifier: "AccountCreatedSegue", sender: nil)
                    
                }
                

                
            }
        
        func handleAuthenticationError(_ error: AuthenticationError) {
            switch error {
            case .invalidEmail:
                print("Invalid email address")
            case .passwordsDoNotMatch:
                print("Passwords do not match")
            case .passwordTooShort:
                print("Password is too short")
            }
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
}
