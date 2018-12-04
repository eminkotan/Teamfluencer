//
//  SecSignUpUserViewController.swift
//  TeamFluncer
//
//  Created by Emin Kotan on 29.11.2018.
//  Copyright © 2018 Team Fluncer. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase
import FirebaseStorage

class SecSignUpUserViewController: UIViewController {
    
    
    @IBOutlet weak var schoolTextField: CustomTextField!
    @IBOutlet weak var cityTextField: CustomTextField!
    @IBOutlet weak var instagramUserNameField: CustomTextField!
    @IBOutlet weak var followerField: CustomTextField!
    @IBOutlet weak var interestsField: CustomTextField!
    @IBOutlet weak var ageField: CustomTextField!
    
    
    var userData = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func toBackButton(_ sender: Any) {
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let destination = segue.destination as? FirstSignUpUserVC {
                destination.nameTextField.text! = userInfo[0].name
                destination.lastnameTextField.text! = userInfo[0].lastName
                
                userInfo.removeAll()
            }
        }
        userInfo.removeAll()
        
    }
    @IBAction func signUpButton(_ sender: Any) {
        if schoolTextField.text != "" && cityTextField.text != "" && instagramUserNameField.text != "" && followerField.text != "" && interestsField.text != "" {
            saveData()
            publishData()
        }else {
            let alert = UIAlertController(title: "Opps", message: "Somewhere is Null", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    func saveData() {
        let school = schoolTextField.text
        let city = cityTextField.text
        let userName = instagramUserNameField.text
        let follower = followerField.text
        let interests = interestsField.text
        let age = ageField.text
        
        let userSpecialData = User(schoolType: "", schoolName: school!, city: city!, instagramUserName: userName!, instaFollower: follower!, interests: interests!)
        
        userInfo.append(userSpecialData)
        
    }
    
    func publishData()  {
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
                let mail = userInfo[0].eMail
                let name = userInfo[0].name
                let lastName = userInfo[0].lastName
                let phone = userInfo[0].phone

                let userInfoData = ["userName" : name , "userLastName" : lastName, "phoneNumber": phone , "userMail": mail , "schoolName": self.schoolTextField.text!, "city": self.cityTextField.text!, "instagramUsername": self.instagramUserNameField.text!, "follower": self.followerField.text, "age": self.ageField.text, "interests": self.interestsField.text!, "isCompany": 0 ] as [String : Any]
                Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!).setValue(userInfoData)
            }
        }
    }
}
