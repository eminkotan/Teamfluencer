//
//  CampaignViewController.swift
//  TeamFluencer
//
//  Created by Emin Kotan on 1.12.2018.
//  Copyright © 2018 Team Fluncer. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher


class CampaignViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var campaignData = [Campaign]()
    var chosenCampaign = [Campaign]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFromFirebase()
        // Do any additional setup after loading the view.
    }
    

    func getDataFromFirebase() {
        let databaseRef = Database.database().reference().child("campaign")
         databaseRef.observe(.childAdded) { (snapshot) in
            if let values = snapshot.value as? NSDictionary{
                let decoder = JSONDecoder()
                do{
                   let data = try JSONSerialization.data(withJSONObject: values, options: .prettyPrinted)
                    let decodedData = try decoder.decode(Campaign.self, from: data)
                    
                    self.campaignData.append(decodedData)
                    self.campaignData.reverse()
                   
                }catch let error {
                    debugPrint(error)
                }
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? UserCampaignDetailViewController{
            destination.chosenCampaign = self.chosenCampaign
          //  let url = URL(string: chosenCampaign[0].image)
           // destination.tableHeaderView.imageView.kf.setImage(with: url)
       
            
         //  destination.tableHeaderView.shortInfoLabel.text = chosenCampaign[0].companyName
        }
    }

}

extension CampaignViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return campaignData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userCampaign", for: indexPath) as! UserCampaignCollectionViewCell
        let url = URL(string: campaignData[indexPath.row].image)
        cell.companyImageView.kf.setImage(with: url)
        cell.companyNameLabel.text = campaignData[indexPath.row].companyName
        cell.campaignBriefLabel.text = campaignData[indexPath.row].brief
        cell.layer.cornerRadius = 6.0
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        cell.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        cell.layer.shadowOpacity = 0.9
        cell.layer.shadowRadius = 11
        cell.layer.masksToBounds = true
        cell.clipsToBounds = false
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        chosenCampaign = [campaignData[indexPath.row]]
        
        performSegue(withIdentifier: "toCampaignDetail", sender: nil)
    }
    
}
