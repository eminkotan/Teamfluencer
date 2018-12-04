//
//  ViewController.swift
//  TeamFluncer
//
//  Created by Emin Kotan on 25.11.2018.
//  Copyright © 2018 Team Fluncer. All rights reserved.
//

import UIKit
import Firebase
import  FirebaseAuth



class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var myData = [Int]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    @IBAction func sıgnInButton(_ sender: Any) {
        if emailTextField != nil && passwordTextField != nil {
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (userData, error) in
                if error == nil{
                    var ref = Database.database().reference()
                    ref.child("users").child((userData?.user.uid)!).observeSingleEvent(of: .value) { (snapshot) in
                        if let value = snapshot.value! as? NSDictionary {
                            let company = value["isCompany"] as? Int
                            self.myData.append(company!)
                            if self.myData[0] == 1 {
                                self.performSegue(withIdentifier: "toCompanyKampanya", sender: nil) //
                            }else {
                                self.performSegue(withIdentifier: "mainPage", sender: nil)
                            }
                          
                        }
                    }
                    //self.performSegue(withIdentifier: "mainPage", sender: nil)
                }else {
                    let alert = UIAlertController(title: "Opps", message: error?.localizedDescription, preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alert.addAction(alertAction)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }else {
            let alert = UIAlertController(title: "Opps", message: "E-mail or password is null", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func forgotPass(_ sender: Any) {
        if emailTextField != nil {
            Auth.auth().sendPasswordReset(withEmail: emailTextField.text!) { (error) in
                if error == nil {
                    let alert = UIAlertController(title: "Congraulations", message: "Check mail Box", preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alert.addAction(alertAction)
                    self.present(alert, animated: true, completion: nil)
                }else {
                    let alert = UIAlertController(title: "Opps", message: error?.localizedDescription, preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alert.addAction(alertAction)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }else {
            let alert = UIAlertController(title: "Opps", message: "E-mail is null", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
        }
        
        
    }
    
    
}

