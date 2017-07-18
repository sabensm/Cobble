//
//  AlertsServices.swift
//  Cobble
//
//  Created by Sabens, Michael G. on 7/17/17.
//  Copyright © 2017 The New Thirty. All rights reserved.
//

import UIKit

protocol AlertController { }
extension AlertController where Self: UIViewController {
    
    func showAlert(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in }
        alertController.addAction(okAction)
        
        view?.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertInModal(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in }
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }

    
    
}
