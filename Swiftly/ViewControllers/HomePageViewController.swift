//
//  HomePageViewController.swift
//  Swiftly
//
//  Created by Akın B on 3/10/24.
//

import UIKit

class HomePageViewController: UIViewController {

    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var chapterOverview: UITableView!
    
    @IBOutlet weak var streakCount: UILabel!
    
//    the fire logo
    @IBOutlet weak var streakLabel: UIImageView!
    @IBOutlet weak var leaderboardButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
