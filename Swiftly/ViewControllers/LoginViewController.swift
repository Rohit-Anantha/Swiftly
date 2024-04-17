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
class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var usernameField: RoundedTextField!
    @IBOutlet weak var passwordField: RoundedTextField!
    
    @IBOutlet weak var logoWidth: NSLayoutConstraint!
    @IBOutlet weak var buttonStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        usernameField.delegate = self
        passwordField.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        let keyboardHeight = keyboardFrame.height
        
        UIView.animate(withDuration: 0.3) {
            self.logo.frame.size = CGSize(width: 50, height: 50)
            self.logoWidth.constant = 50
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            // Reset logo height and position
            self.logo.frame.size = CGSize(width: 300, height: 300)
            self.logoWidth.constant = 300
            // self.logo.frame.size =
            
            // Reset the positions of other UI elements
            
            self.view.layoutIfNeeded()
        }
    }
    
    // Called when the user clicks on the view outside of the UITextField
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //        do{
        //            try Auth.auth().signOut()
        //        }catch{
        //            print(error)
        //        }
        Auth.auth().addStateDidChangeListener { auth, user in
            if(user != nil){
                self.performSegue(withIdentifier: "LoggedInSegue", sender: nil)
            }
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
                        
                        self.showAlert("User does not exist!")
                        
                    }else{
                        self.performSegue(withIdentifier: "LoggedInSegue", sender: nil)
                    }
                }
            /*
             Create Segue to home Page
             }
             */
            
            
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
        }catch{
            print(error)
        }
    }
    
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
