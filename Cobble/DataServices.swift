//
//  DataServices.swift
//  Cobble
//
//  Created by Sabens, Michael G. on 6/17/17.
//  Copyright © 2017 The New Thirty. All rights reserved.
//

import Foundation
import Firebase

let DATABASE_URL = Database.database().reference() // containts the root URL for the database


class FirebaseDataService {
    
    //make class a singleton
    static let database = FirebaseDataService()
    
    private var _baseURL = DATABASE_URL
    private var _getRecipeURL = DATABASE_URL.child("recipes")
    private var _getUsersURL = DATABASE_URL.child("users")
    
    var BASE_URL: DatabaseReference {
        return _baseURL
    }
    
    var RECIPES_URL: DatabaseReference {
        return _getRecipeURL
    }
    
    var USERS_URL: DatabaseReference {
        return _getUsersURL
    }
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>) {
        USERS_URL.child(uid).updateChildValues(userData)
    }
    
}
