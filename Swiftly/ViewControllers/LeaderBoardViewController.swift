//
//  LeaderBoardViewController.swift
//  Swiftly
//
//  Created by Akın B on 3/13/24.
//

import UIKit
class Person{
    var name:String
    var score: Int64
    
    init(name: String, score: Int64) {
        self.name = name
        self.score = score
    }
}

/*
 MARK: - LeaderBoard
 
Here the user will be able to compare themselves with the rest of the users. This page is accessed through the Leaderboard button on the home tab.
 */
class CustomTableViewCell: UITableViewCell {
    // Declare outlets for the labels
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var medalImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension UIColor {
    static var goldColor: UIColor {
        return UIColor(red: 1.0, green: 0.843, blue: 0.0, alpha: 1.0) // Adjust the RGB values as needed
    }

    static var bronzeColor: UIColor {
        return UIColor(red: 0.804, green: 0.522, blue: 0.247, alpha: 1.0) // Adjust the RGB values as needed
    }
}


class LeaderBoardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var leaderBoardTableView: UITableView!
    var ds: [User] = []{
        didSet{
            leaderBoardTableView.reloadData()
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("ds count " + String(ds.count))
        return ds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        let row = indexPath.row + 1
        var cell: CustomTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "GoldPlaceCell", for: indexPath)as? CustomTableViewCell)!
        
        cell.nameLabel.text = ds[indexPath.row].userName
        cell.scoreLabel.text = String(ds[indexPath.row].totalScore)
        switch (row) {
        case 1:
            cell.medalImage.tintColor = UIColor.goldColor
            
        case 2:
//            Silver
            cell.medalImage.tintColor = UIColor.lightGray
        case 3:
//            Bronze
            cell.medalImage.tintColor = UIColor.bronzeColor
        default:
            cell.medalImage.isHidden = true
        }
        
        
        
        return cell
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        leaderBoardTableView.delegate = self
        leaderBoardTableView.dataSource = self
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
