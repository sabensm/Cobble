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

class LoginScreenVC: UIViewController {

    //E-mail and Password Text Field Outlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    //Facebook Login
    
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
                self.firebaseAuth(credential)
            }
        }
    }
    
    
    //Twitter Login
    
    
    @IBAction func twitterButtonTapped(_ sender: Any) {
    }
    
    
    //Email Login
    
    @IBAction func emailButtonTapped(_ sender: Any) {
        //check to make sure we have text in the email and password fields
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    print("User authenticed with Firebase using email and password")
                    if let user = user {
                        let userData = ["email": user.email]
                        self.completeSignIn(id: user.uid, userData: userData as! Dictionary<String, String>)
                    }
                } else {
                    Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil {
                            print("Unable to authenticate with Firebase using email and password")
                        } else {
                            print("Successfully create user in Firebase")
                            if let user = user {
                                let userData = ["email": user.email]
                                self.completeSignIn(id: user.uid, userData: userData as! Dictionary<String, String>)
                            }
                        }
                    })
                }
            })
        }
    }
    
    //Firebase Authentication
    
    func firebaseAuth(_ credential: AuthCredential) {
        Auth.auth().signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("Unable to authenticate with Firebase")
            } else {
                print("Successfuly authenticated with Firebase")
                if let user = user {
                    let userData = ["email": user.email]
                    self.completeSignIn(id: user.uid, userData: userData as! Dictionary<String, String>)
                }
                
            }
        })
    }
    
    func completeSignIn(id: String, userData: Dictionary<String, String>) {
        FirebaseDataService.database.createFirebaseDBUser(uid: id, userData: userData) //Creating user in firebase
        KeychainWrapper.standard.set(id, forKey: KEY_UID) // setting the UID for firebase user to our keychain
        UserServices.users.currentUser = Auth.auth().currentUser // setting the global varialble of current user to the firebase authed user
        emailTextField.text = ""
        passwordTextField.text = ""
        performSegue(withIdentifier: "goToMain", sender: nil) // transitioning to main VC
    }
    
    
    //If user is already logged in, skip the screen
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            performSegue(withIdentifier: "goToMain", sender: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
