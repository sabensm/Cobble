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

class CreateAccountVC: UIViewController, AlertController {
    
    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    var alertView: UIAlertController?

    
    @IBAction func createAccountButtonPressed(_ sender: Any) {
        
        guard let email = emailText.text, email.isValidEmail() else {
            showAlertInModal(title: "Invalid E-mail", message: "The email address you entered is invalid, please enter a valid e-mail address.")
            return
        }
        
        guard let password = passwordText.text, isPasswordValid(password) else {
            showAlertInModal(title: "Invalid Password", message: "Your password needs to be at least 6 characters. Please enter a valid password")
            return
        }
        
        guard let firstName = firstNameText.text, firstName != "" else {
            showAlertInModal(title: "Missing First Name", message: "Please enter your first name")
            return
        }
        
        guard let lastName = lastNameText.text, lastName != "" else {
            showAlertInModal(title: "Missing Last Name", message: "Please enter your last name")
            return
        }

        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                self.showAlert(title: "Server Error", message: "Unable to create account")
            } else {
                let displayName = "\(firstName) \(lastName)"
                if let user = user {
                    let userData = ["email": user.email, "firstName": firstName, "lastName": lastName, "displayName": displayName]
                    Auth.auth().currentUser?.setValue(displayName, forKey: "displayName")
                    self.completeSignIn(id: user.uid, userData: userData as! Dictionary<String, String>)
                }
            }
        })
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
    
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])[A-Za-z\\d$@$#!%*?&]{6,}")
        return passwordTest.evaluate(with: password)
    }
    
}
