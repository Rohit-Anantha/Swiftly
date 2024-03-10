//
//  SettingsViewController.swift
//  Swiftly
//
//  Created by Akın B on 3/10/24.
//

import UIKit

let settings = [
"Account",
"Theme",
"Language",
"Rate us",
"Sign out"
]

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsItemCell", for: indexPath)
        
        let row = indexPath.row
        cell.textLabel?.text = settings[row]
        return cell
    }
    

    @IBOutlet weak var settingsOverview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        settingsOverview.delegate = self
        settingsOverview.dataSource = self
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
