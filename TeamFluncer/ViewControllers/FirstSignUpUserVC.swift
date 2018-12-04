//
//  FirstSignUpUserVC.swift
//  TeamFluncer
//
//  Created by Emin Kotan on 27.11.2018.
//  Copyright © 2018 Team Fluncer. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase


var userInfo = [User]()


class FirstSignUpUserVC: UIViewController {

    @IBOutlet weak var nameTextField: CustomTextField!
    @IBOutlet weak var lastnameTextField: CustomTextField!
    
    @IBOutlet weak var mailTextField: CustomTextField!
    @IBOutlet weak var phoneUserName: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!

    
      @IBOutlet var segment: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    

 
 
 
    @IBAction func didSelected(_ sender: UISegmentedControl) {
        switch segment.selectedSegmentIndex {
        case 0:
            break
        case 1:
            performSegue(withIdentifier: "company", sender: nil)
        default:
            break
        }
    }
    
    
    
    
    @IBAction func tappedNextButton(_ sender: Any) {
        if nameTextField.text != "" && lastnameTextField.text != "" && mailTextField.text != "" && phoneUserName.text != "" && passwordTextField.text != "" {
        saveInfo()
performSegue(withIdentifier: "secSignUp", sender: nil)
        
        }else {
            let alert = UIAlertController(title: "Opps", message: "Somewhere is  null", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
            
        }
        
        
    }
    
    @IBAction func button(_ sender: Any) {
        
    }
    
    
    
    // Functions
    
    func saveInfo()  {
        let name = nameTextField.text
        let lastName = lastnameTextField.text
        let mail = mailTextField.text
        let phone = phoneUserName.text
        let password = passwordTextField.text
        
        let userData = User(name: name!, lastName: lastName!, eMail: mail!, password: password!, phone: phone!)
        userInfo.append(userData)
    }
    
}

/*
 if nameNSchoolTextField.text != "" && lastnameNCityTextField.text != "" && mailNSchoolChoseTextField.text != "" && phoneNInstagramUserName.text != "" && passwordTextField.text != "" {
 Auth.auth().createUser(withEmail: userInfo[0].eMail, password: userInfo[0].password) { (userData, error) in
 if error != nil{
 let alert = UIAlertController(title: "Opps", message: error?.localizedDescription, preferredStyle: .alert)
 let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
 alert.addAction(alertAction)
 self.present(alert, animated: true, completion: nil)
 }else {
 let alert = UIAlertController(title: "Congratulations", message: "Successfully Signed Up", preferredStyle: .alert)
 let okAlert = UIAlertAction(title: "Keep Go", style: .cancel, handler: nil)
 alert.addAction(okAlert)
 self.present(alert, animated: true, completion: nil)
 
 let userInfo = ["userName" : self.nameNSchoolTextField.text!, "userLastName" : self.lastnameNCityTextField.text!, "phoneNumber": self.phoneNInstagramUserName.text!] as [String : Any]
 Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!).child("influencers").child("profileInfo").setValue(userInfo)
 }
 }
 }else {
 let alert = UIAlertController(title: "Opps", message: "Somewhere is  null", preferredStyle: .alert)
 let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
 alert.addAction(alertAction)
 self.present(alert, animated: true, completion: nil)
 }
 

 */


