//
//  CompanyCampaignViewController.swift
//  TeamFluencer
//
//  Created by Emin Kotan on 1.12.2018.
//  Copyright © 2018 Team Fluncer. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher


class CompanyCampaignViewController: UIViewController {

    @IBOutlet weak var campaignCollevtionView: UICollectionView!
    
    
    var companyData  = [Campaign]()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataFromFirebase()
        // Do any additional setup after loading the view.
    }
    

  
    @IBAction func toCreateCampaign(_ sender: Any) {
        performSegue(withIdentifier: "toCreateCampaign", sender: nil)
    }
    

    func getDataFromFirebase() {
        let databaseRef = Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!).child("campaigns")
        databaseRef.observe(.childAdded) { (snapshot) in
            if let values = snapshot.value as? NSDictionary{ // veri kontrol et değilse uygulamada error vermesin datayı snapshot olarak çek
                
                let decoder = JSONDecoder()
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: values, options: .prettyPrinted) // Json Dataya çevir
                    let companyRecievedData = try decoder.decode(Campaign.self, from: jsonData) // Datayı decode et
                    self.companyData.append(companyRecievedData)
                    self.companyData.reverse()
                }catch let error {
                    debugPrint(error)
                }
            }
            
            DispatchQueue.main.async { // Ekranı main thread'de kullanırken datayı collectionview'e doldur
                self.campaignCollevtionView.reloadData()
            }
        }
    }

}
extension CompanyCampaignViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return companyData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = campaignCollevtionView.dequeueReusableCell(withReuseIdentifier: "collectionView", for: indexPath) as! CompanyCollectionViewCell
        let url = URL(string: companyData[indexPath.row].image)
        cell.companyImageView.kf.setImage(with: url)
        cell.companyNameLabel.text = companyData[indexPath.row].companyName
        cell.campaignBriefLabel.text = companyData[indexPath.row].brief
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
    
  
    
    
    
}
