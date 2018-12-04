//
//  CreateCampaignViewController.swift
//  TeamFluencer
//
//  Created by Emin Kotan on 1.12.2018.
//  Copyright © 2018 Team Fluncer. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage



class CreateCampaignViewController: UIViewController {
    
    // UI Elements
    @IBOutlet weak var companyImage: UIImageView!
    @IBOutlet weak var companyNameField: UITextField!
    @IBOutlet weak var briefField: UITextField!
    @IBOutlet weak var minAgeField: UITextField!
    @IBOutlet weak var maxAgeField: UITextField!
    @IBOutlet weak var costField: UITextField!
    @IBOutlet weak var kisiField: UITextField!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
companyImage.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.selectImage))
        companyImage.addGestureRecognizer(gestureRecognizer)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func createCampaign(_ sender: Any) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let mediaFolder = storageRef.child("campaignImage")
        if let data = companyImage.image?.jpegData(compressionQuality: 0.5){
            var uuid = NSUUID().uuidString
            let mediaImagesRef = mediaFolder.child("\(uuid).jpg")
            mediaImagesRef.putData(data, metadata: nil) { (metaData, error) in
                if error != nil {
                    let alert = UIAlertController(title: "Opps", message: error?.localizedDescription, preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    alert.addAction(alertAction)
                    self.present(alert, animated: true, completion: nil)
                }else {
                    mediaImagesRef.downloadURL(completion: { (url, error) in
                        if error == nil {
                            let imageURL = url?.absoluteString
                            let databaseRef = Database.database().reference()
                            
                            if let cost = Int(self.costField.text!){
                                let bütce = (cost * 70) / 100
                                let kisiPara = bütce / Int(self.kisiField.text!)!
                                
                                
                                if kisiPara >= 5 {
                                    let campaign = ["image": imageURL!, "companyName": self.companyNameField.text!, "brief": self.briefField.text!, "minAge": self.minAgeField.text!, "maxAge": self.maxAgeField.text!, "bütçe": self.costField.text!, "kisiSayisi": self.kisiField.text!, "uuid": uuid, "kisiPara": kisiPara] as [String: Any]
                                    
                                    databaseRef.child("users").child((Auth.auth().currentUser?.uid)!).child("campaigns").childByAutoId().setValue(campaign)
                                   databaseRef.child("campaign").childByAutoId().setValue(campaign)
                                    self.performSegue(withIdentifier: "toMyCampaigns", sender: nil)
                                    
                                        
                                }else {
                                    let alert = UIAlertController(title: "Opps", message: "Bütçe ve kişi sayısını yeniden gözden geçirin", preferredStyle: .actionSheet)
                                    let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                                    alert.addAction(alertAction)
                                    self.present(alert, animated: true, completion: nil)
                                }
                            }
                           
                        }
                    })
                }
            }
        }
        
    }
    
  
    
 
}

extension CreateCampaignViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func selectImage() {
        let pickController = UIImagePickerController()
        pickController.delegate = self
        pickController.sourceType = .photoLibrary
        pickController.allowsEditing = true
        present(pickController, animated: true, completion: nil)

        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        companyImage.image = info[.originalImage] as? UIImage
         self.dismiss(animated: true, completion: nil)
        
        
    }

}
