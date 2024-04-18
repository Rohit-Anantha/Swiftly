//
//  SplashViewController.swift
//  Swiftly
//
//  Created by Akın B on 4/13/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

var currentUser: User!

//MARK: SplashViewController
//This VC is to load data before loading the app features, any additional data pull can be done here
//currentUser variable is initiated here!
class SplashViewController: UIViewController {

    private let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        Task{
            do {
                currentUser = try await db.collection("users").document(Auth.auth().currentUser!.uid).getDocument(as: User.self)
                // Update UI or perform further actions based on the retrieved data
            
                
                // Perform the segue once the data is loaded
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "DataLoadedSegue", sender: nil)
                }
            } catch {
                print("Error fetching user data: \(error)")
                // Handle the error appropriately, e.g., display an alert to the user
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
