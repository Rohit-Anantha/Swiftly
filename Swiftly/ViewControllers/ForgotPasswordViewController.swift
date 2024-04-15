//
//  ForgotPasswordViewController.swift
//  Swiftly
//
//  Created by Rohit Anantha on 4/8/24.
//

import UIKit

import FirebaseAuth
class ForgotPasswordViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailBox: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailBox.delegate = self

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
