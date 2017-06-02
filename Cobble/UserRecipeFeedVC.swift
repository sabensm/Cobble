//
//  UserRecipeFeedVC.swift
//  Cobble
//
//  Created by Sabens, Michael G. on 6/2/17.
//  Copyright © 2017 The New Thirty. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class UserRecipeFeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func signoutButtonTapped(_ sender: Any) {
        if (self.presentingViewController != nil) {
            self.dismiss(animated: false, completion: nil)
        }
        let _ = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        try! Auth.auth().signOut()
        print("User is signed out")
    }
}

