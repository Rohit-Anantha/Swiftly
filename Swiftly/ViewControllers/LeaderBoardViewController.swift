////
////  LeaderBoardViewController.swift
////  Swiftly
////
////  Created by Akın B on 3/13/24.
////
//
//import UIKit
//
//
//
//
//
//
//class LeaderBoardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
//    @IBOutlet weak var leaderBoardTableView: UITableView!
//    var ds: [User] = []{
//        didSet{
//            leaderBoardTableView.reloadData()
//            
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("ds count " + String(ds.count))
//        return ds.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        
//        let row = indexPath.row + 1
//        let cell: CustomTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "GoldPlaceCell", for: indexPath)as? CustomTableViewCell)!
//        
//        cell.nameLabel.text = ds[indexPath.row].userName
//        cell.scoreLabel.text = String(ds[indexPath.row].totalScore)
//        switch (row) {
//        case 1:
//            cell.medalImage.tintColor = UIColor.goldColor
//            
//        case 2:
////            Silver
//            cell.medalImage.tintColor = UIColor.lightGray
//        case 3:
////            Bronze
//            cell.medalImage.tintColor = UIColor.bronzeColor
//        default:
//            cell.medalImage.isHidden = true
//        }
//        
//        
//        
//        return cell
//    }
//    
//
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Do any additional setup after loading the view.
//        leaderBoardTableView.delegate = self
//        leaderBoardTableView.dataSource = self
//    }
//    
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
