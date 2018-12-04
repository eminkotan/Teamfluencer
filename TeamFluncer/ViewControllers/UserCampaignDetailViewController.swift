//
//  UserCampaignDetailViewController.swift
//  TeamFluencer
//
//  Created by Emin Kotan on 3.12.2018.
//  Copyright © 2018 Team Fluncer. All rights reserved.
//

import UIKit
import Kingfisher

class UserCampaignDetailViewController: UIViewController {

    var chosenCampaign = [Campaign]()
    @IBOutlet weak var tableHeaderView: TableHeaderView!
    @IBOutlet weak var tableView: UITableView!
    
    class var identifier: String {
        return String(describing: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: chosenCampaign[0].image)
        self.tableHeaderView.imageView.kf.setImage(with: url)
        tableHeaderView.shortInfoLabel.text = chosenCampaign[0].companyName
        tableView.tableHeaderView = tableHeaderView
        tableView.estimatedRowHeight = 300
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

extension UserCampaignDetailViewController: UITableViewDelegate, UITableViewDataSource{

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "requireCell", for: indexPath) as! RequireTableViewCell 
            cell.ageLabel.text = "\(chosenCampaign[indexPath.row].minAge) - \(chosenCampaign[indexPath.row].maxAge)"
            cell.subsLabel.text = chosenCampaign[indexPath.row].kisiSayisi
            cell.briefLabel.text = chosenCampaign[indexPath.row].brief
            return cell
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
   
}
