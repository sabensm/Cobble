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

class UserRecipeFeedVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedItemCell") as! RecipeCard
        return cell
    }

}

