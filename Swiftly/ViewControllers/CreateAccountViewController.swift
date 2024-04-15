//
//  CreateAccountViewController.swift
//  Swiftly
//
//  Created by Akın B on 3/9/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

enum AuthenticationError: Error {
    case invalidEmail
    case passwordsDoNotMatch
    case passwordTooShort
    case loginFailed
    case emptyUsername
}

/*
 MARK: - Create Account
 
 Screen for users that are creating an account. Accessed via the "Create Account" button on the Login Page
 */
class CreateAccountViewController: UIViewController, UITextFieldDelegate {
    
    
    
    @IBOutlet weak var emailField: RoundedTextField!
    @IBOutlet weak var usernameField: RoundedTextField!
    @IBOutlet weak var newPasswordField: RoundedTextField!
    @IBOutlet weak var confirmPasswordField: RoundedTextField!
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newPasswordField.delegate = self
        confirmPasswordField.delegate = self
        usernameField.delegate = self
        emailField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Called when the user clicks on the view outside of the UITextField
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
            
            guard newPasswordField.text == confirmPasswordField.text else {
                throw AuthenticationError.passwordsDoNotMatch
            }
            
            guard password.count > 7 else {
                throw AuthenticationError.passwordTooShort
            }
            
            guard userName != "" else{
                throw AuthenticationError.emptyUsername
            }
            
            // Code to register the user if all validations pass
            
        } catch let error as AuthenticationError {
            var errorMessage: String
            
            switch error {
            case .invalidEmail:
                errorMessage = "Invalid email address"
            case .passwordsDoNotMatch:
                errorMessage = "Passwords do not match"
            case .passwordTooShort:
                errorMessage = "Password is too short. It should be at least 8 characters long."
            case .loginFailed:
                errorMessage = "Login failed. Please try again later."
            case .emptyUsername:
                errorMessage = "Username cannot be empty."
            }
            
            // Show alert with error message
            showAlert(errorMessage)
            // stop creating the user
            return
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
                    let db = Firestore.firestore()
                    let newUserData = User(userName: self.userName, streakCount: 1, currentLevel: 0, totalScore: 0, chapterScores: [], lastLogIn: Date().timeIntervalSince1970)
                    
                    Task {
                        do {
                            try await db.collection("users").document(Auth.auth().currentUser!.uid).setData(from: newUserData)
                            //                            currentUser = newUserData
                        } catch {
                            showAlert("Error occured when creating account!")
                        }
                    }
                    self.performSegue(withIdentifier: "AccountCreatedSegue", sender: nil)
                    
                }else{
                    print("error creating account: " + error!.localizedDescription)
                    showAlert(error!.localizedDescription)
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
            case .loginFailed:
                print("Here1")
            case .emptyUsername:
                print("Here2")
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
        
        func showAlert(_ message: String) {
            let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            // Get the top-most view controller
            if var topController = UIApplication.shared.windows.first?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                
                // Present the alert on the top-most view controller
                topController.present(alertController, animated: true, completion: nil)
            }
        }
        
    }
}
