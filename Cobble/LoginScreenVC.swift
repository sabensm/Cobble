//
//  LoginScreenVC.swift
//  Cobble
//
//  Created by Sabens, Michael G. on 6/2/17.
//  Copyright © 2017 The New Thirty. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper

class LoginScreenVC: UIViewController, AlertController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    
    @IBAction func facebookButtonTapped(_ sender: Any) {
        //Authenticate with Facebook to allow app to get info from FB to usein app
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("Unable to authentica with Facebook")
            } else if result?.isCancelled == true {
                print("User cancelled Facebook auth")
            } else {
                print("Successfully authenticated with Facebook")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                print(FBSDKProfile.current().firstName)
                self.firebaseAuth(credential)
            }
        }
    }
    
    
    @IBAction func twitterButtonTapped(_ sender: Any) {
        //TODO auth with twitter
    }
    
    
    @IBAction func emailButtonTapped(_ sender: Any) {
        //check to make sure we have text in the email and password fields
        
        guard let email = emailTextField.text, email.isValidEmail() else {
            showAlertInModal(title: "Invalid E-mail", message: "Please enter a valid e-mail address")
            return
        }
        
        if let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                if error != nil {
                    self.showAlertInModal(title: "Login Error", message: "Please check your password is correct and try again.")
                } else {
                    if let user = user {
                        let userData = ["email": user.email]
                        self.completeSignIn(id: user.uid, userData: userData as! Dictionary<String, String>)
                    }
                }
            })
        }
    }
    
    //Firebase Authentication
    
    func firebaseAuth(_ credential: AuthCredential) {
        Auth.auth().signIn(with: credential, completion: { (user, error) in
            if error != nil {
            self.showAlertInModal(title: "Login Error", message: "Please check your username and password are correct and try again. If you forgot them, use the Forgot password button")
            } else {
                if let user = user {
                    let userData = ["email": user.email]
                    self.completeSignIn(id: user.uid, userData: userData as! Dictionary<String, String>)
                }
                
            }
        })
    }
    
    func completeSignIn(id: String, userData: Dictionary<String, String>) {
        KeychainWrapper.standard.set(id, forKey: KEY_UID) // setting the UID for firebase user to our keychain
        UserServices.users.currentUser = Auth.auth().currentUser // setting the global varialble of current user to the firebase authed user
        emailTextField.text = ""
        passwordTextField.text = ""
        if (self.presentingViewController != nil) {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
