//
//  ForgotPasswordViewController.swift
//  Swiftly
//
//  Created by Rohit Anantha on 4/8/24.
//

import UIKit

import FirebaseAuth
class ForgotPasswordViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var logoWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var emailBox: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailBox.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
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
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] is CGRect else {
            return
        }
        
        UIView.animate(withDuration: 0.3) {
            self.logoView.frame.size = CGSize(width: 50, height: 50)
            self.logoWidthConstraint.constant = 50
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            // Reset logo height and position
            self.logoView.frame.size = CGSize(width: 300, height: 300)
            self.logoWidthConstraint.constant = 300
            // self.logo.frame.size =
            
            // Reset the positions of other UI elements
            
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func forgotPasswordPressed(_ sender: Any) {
        Auth.auth().sendPasswordReset(withEmail: emailBox.text!){ error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("success")
                let controller = UIAlertController(title: "Success!", message: "Check your Email to reset your password!", preferredStyle: .alert)
                let dismiss = UIAlertAction(title: "Back", style: .default)
                controller.addAction(dismiss)
                self.present(controller, animated: false)
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
    
}
