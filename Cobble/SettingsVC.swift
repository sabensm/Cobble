//
//  SettingsVC.swift
//  Cobble
//
//  Created by Sabens, Michael G. on 6/11/17.
//  Copyright © 2017 The New Thirty. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase
import MessageUI

class SettingsVC: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var settingsAboutText: UILabel!
    
    @IBAction func signoutButtonTapped(_ sender: Any) {
        
        if (self.presentingViewController != nil) {
            self.dismiss(animated: false, completion: nil)
        }
        let _ = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        try! Auth.auth().signOut()
        print("User is signed out")
        
    }
    
    @IBAction func sendEmailButtonTapped(_ sender: Any) {
        if !MFMailComposeViewController.canSendMail() {
            print("Mail services not available at this time")
            return
        }
        sendEmail()
    }
    
    @IBAction func twitterButtonTapped(_ sender: Any) {
        let vc = LoadFullPageWebviewVC()
        vc.recievedUrl = "https://twitter.com/espn"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func webpageButtonTapped(_ sender: Any) {
        let vc = LoadFullPageWebviewVC()
        vc.recievedUrl = "http://www.espn.com"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settingsAboutText.text = "Cobble is a recipie sharing app with an emphasis on ease of use and security. Share recipies with family, friends, or just add as a top secret recipe for your eyes only. \n\nCobble makes it easy to keep all your recipes in one place and easily accesible. \n\nSpecial thanks to my wife Gina and all the friends who helped with this app. More great features will be added in the future. \n\nThank you all for using and enjoying Cobble. If you have questions, comments or concerns, please get in touch with us using any of the methods below."
        
        self.navigationItem.title = "Settings"
    }
    
    //function to send an e-mail
    
    func sendEmail() {
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        //configure fields
        composeVC.setToRecipients(["Michael.Sabens@me.com"])
        composeVC.setSubject("Feeback on Cobble App")
        composeVC.setMessageBody("", isHTML: false)
        //present the view controller
        self.present(composeVC, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
