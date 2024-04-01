//
//  HomePageViewController.swift
//  Swiftly
//
//  Created by Akın B on 3/10/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class HomePageViewController: UIViewController {
    
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var chapterOverview: UITableView!
    
    @IBOutlet weak var streakCount: UILabel!
    
    //    the fire logo
    @IBOutlet weak var streakLabel: UIImageView!
    @IBOutlet weak var leaderboardButton: UIButton!
    
    private let db = Firestore.firestore()
    
    override func viewWillAppear(_ animated: Bool) {
        Task {
            do {
                let currentUser = try await db.collection("users").document(Auth.auth().currentUser!.uid).getDocument(as: User.self)
                // Update UI or perform further actions based on the retrieved data
                userName.text = currentUser.userName
                
            } catch {
                print("Error fetching user data: \(error)")
                // Handle the error appropriately, e.g., display an alert to the user
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        let count:Int? = currentUser?.streakCount
//        streakCount.text = String(count)
        email.text = Auth.auth().currentUser?.email
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LeaderboardSegue",
           let nextVC = segue.destination as? LeaderBoardViewController {
            let ds = [Person(name:"Tom", score: 300),
                      Person(name:"Charlie", score: 350),
                      Person(name:"Franklin", score: 100),
                      Person(name:"Alissa", score: 600),
                      Person(name:"Jane", score: 100),
                      
            ]
            let sortedArray = ds.sorted(by: { $0.score > $1.score })
            nextVC.ds = sortedArray
            
            
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
