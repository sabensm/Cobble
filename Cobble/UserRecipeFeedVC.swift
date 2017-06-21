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
    
    //array of recipe posts that we get from Firebase and store
    var recipesArray = [Recipe]()
    var recipeInformation: Recipe!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.allowsMultipleSelectionDuringEditing = true
        
        //setup listener on the database to fetch data whenever there is a change
        FirebaseDataService.database.RECIPES_URL.observe(.value, with: { (snapshot) in
            //clear array each time we get new data so we're not duplicating it
            self.recipesArray = []
            //breaking out all the data into an individual object
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    if let recipesDictionary = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let recipe = Recipe.init(recipeID: key, recipeData: recipesDictionary)
                        //if statement to only add to array if the user ID in the post is == current user id. 
                        if recipe.recipeUserID == UserServices.users.currentUser?.uid {
                            self.recipesArray.append(recipe)
                        }
                    }
                }
            }
            self.tableView.reloadData()
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let recipe = recipesArray[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "feedItemCell") as? RecipeCard {
            cell.configureCell(recipe: recipe)
            return cell
            }
            return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        //This code will delete the recipe from the recipes portion of the database.
        let selectedRecipe = recipesArray[indexPath.row]
        let recipeToDelete = selectedRecipe.recipeID
        print(recipeToDelete)
        FirebaseDataService.database.RECIPES_URL.child(recipeToDelete).removeValue()
        
        //This code will delete the reference to the recipe from the users portion of the database.
        
        if let currentUser = UserServices.users.currentUser?.uid {
            FirebaseDataService.database.USERS_URL.child(currentUser).child("posts").child(recipeToDelete).removeValue()
        }
    }

}
