//
//  ViewController.swift
//  Instagram
//
//  Created by Anirudh V on 8/9/18.
//  Copyright © 2018 Anirudh V. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {
   
    @IBOutlet weak var UserNameField: UITextField!
    
    @IBOutlet weak var PassWordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func OnSignIn(_ sender: Any) {
        let username = UserNameField.text ?? ""
        let password = PassWordField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
            } else {
                print("User logged in successfully")
                self.performSegue(withIdentifier: "LoginSuccess", sender: nil)
            }
        }
    }
    @IBAction func OnSignUp(_ sender: Any) {
        let newUser = PFUser()
        
        // set user properties
        newUser.username = UserNameField.text
        
        newUser.password = PassWordField.text
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User Registered successfully")
                // manually segue to logged in view
            }
        }
    }
}

