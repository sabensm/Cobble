//
//  UserServices.swift
//  Cobble
//
//  Created by Sabens, Michael G. on 6/19/17.
//  Copyright © 2017 The New Thirty. All rights reserved.
//

import Foundation
import Firebase

let FIREBASE_AUTH = Auth.auth()

class UserServices {
    
    static let users = UserServices() // making this a singleton
    
    var currentUser = FIREBASE_AUTH.currentUser

}
