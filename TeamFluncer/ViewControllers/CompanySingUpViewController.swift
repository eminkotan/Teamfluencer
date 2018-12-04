//
//  CompanySingUpViewController.swift
//  TeamFluncer
//
//  Created by Emin Kotan on 28.11.2018.
//  Copyright © 2018 Team Fluncer. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class CompanySingUpViewController: UIViewController {

    @IBOutlet var seg: UISegmentedControl!
    @IBOutlet weak var contactFullNameField: CustomTextField!
    @IBOutlet weak var companyField: CustomTextField!
    @IBOutlet weak var mailField: CustomTextField!
    @IBOutlet weak var phoneField: CustomTextField!
    @IBOutlet weak var passwordField: CustomTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        seg.selectedSegmentIndex = 1
    }
    
    @IBAction func didSelected(_ sender: Any) {
        switch seg.selectedSegmentIndex {
        case 0:
            performSegue(withIdentifier: "toInfluencer", sender: nil)
        case 1:
            break
        default:
            break
        }
    }
    @IBAction func tappedSignUp(_ sender: Any) {
        if contactFullNameField.text != "" && companyField.text != "" && mailField.text != "" && phoneField.text != "" && passwordField.text != ""{
            Auth.auth().createUser(withEmail: mailField.text!, password: passwordField.text!) { (userData, error) in
                if error != nil{
                    let alert = UIAlertController(title: "Opps", message: error?.localizedDescription, preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    alert.addAction(alertAction)
                    self.present(alert, animated: true, completion: nil)
                    
                }else {
                    let alert = UIAlertController(title: "Success", message: "You have signed Up successfuly", preferredStyle: .actionSheet)
                    let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    alert.addAction(alertAction)
                    self.present(alert, animated: true, completion: nil)
                    
                    let companyInfoData = ["companyName": self.companyField.text!, "contactName": self.contactFullNameField.text!, "companyMail": self.mailField.text!, "companyPhone": self.phoneField.text!, "isCompany": 1 ] as [String: Any]
                    
                    Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!).setValue(companyInfoData)
                }
            }
        }
    }
    


}
