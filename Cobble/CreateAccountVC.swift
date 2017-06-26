//
//  CreateAccountVC.swift
//  Cobble
//
//  Created by Sabens, Michael G. on 6/21/17.
//  Copyright © 2017 The New Thirty. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class CreateAccountVC: UIViewController {
    
    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!

    
    @IBAction func createAccountButtonPressed(_ sender: Any) {
        
        if let email = emailText.text, let password = passwordText.text, let firstName = firstNameText.text, let lastName = lastNameText.text {
            Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                if error != nil {
                    print("Unable to authenticate with Firebase using email and password")
                } else {
                    print("Successfully create user in Firebase")
                    let displayName = "\(firstName) \(lastName)"
                    if let user = user {
                        let userData = ["email": user.email, "firstName": firstName, "lastName": lastName, "displayName": displayName]
                        Auth.auth().currentUser?.setValue(displayName, forKey: "displayName")
                        self.completeSignIn(id: user.uid, userData: userData as! Dictionary<String, String>)
                    }
                }
            })

        }
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        
        self.dismiss(animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func completeSignIn(id: String, userData: Dictionary<String, String>) {
        
        FirebaseDataService.database.createFirebaseDBUser(uid: id, userData: userData) //Creating user in firebase
        KeychainWrapper.standard.set(id, forKey: KEY_UID) // setting the UID for firebase user to our keychain
        UserServices.users.currentUser = Auth.auth().currentUser // setting the global varialble of current user to the firebase authed user
        firstNameText.text = ""
        lastNameText.text = ""
        emailText.text = ""
        passwordText.text = ""
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil) //dismissing all VC's to get back to root.
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
}
