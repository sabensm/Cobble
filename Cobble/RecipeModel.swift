//
//  RecipeModel.swift
//  Cobble
//
//  Created by Sabens, Michael G. on 6/18/17.
//  Copyright © 2017 The New Thirty. All rights reserved.
//

import Foundation

class Recipe {
    
    private var _recipeID: String
    private var _recipeName: String?
    private var _recipeServes: Int?
    private var _recipeTime: String?
    private var _recipeCategory: String?
    private var _recipeImageURL: String?
    private var _recipeAuthor: String?
    
    var recipeID: String {
        return _recipeID
    }
    
    var recipeName: String {
        return _recipeName!
    }
    
    var recipeServes: Int? {
        return _recipeServes!
    }
    
    var recipeTime: String {
        return _recipeTime!
    }
    
    var recipeCategory: String {
        return _recipeCategory!
    }
    
    var recipeImageURL: String {
        return _recipeImageURL!
    }
    
    var recipeAuthor: String {
        return _recipeAuthor!
    }
    
    //initalize all the variables
    
    init(recipeID: String, recipeName: String, recipeServes: Int, recipeTime: String, recipeCategory: String, recipeImageURL: String, recipeAuthor: String) {
        self._recipeID = recipeID
        self._recipeName = recipeName
        self._recipeServes = recipeServes
        self._recipeTime = recipeTime
        self._recipeCategory = recipeCategory
        self._recipeImageURL = recipeImageURL
        self._recipeAuthor = recipeAuthor
    }
    
    //create data and dictionary to store values
    
    init(recipeID: String, recipeData: Dictionary<String, AnyObject>) {
        
        self._recipeID = recipeID
        
        if let recipeName = recipeData["name"] as? String {
            self._recipeName = recipeName
        }
        
        if let recipeServes = recipeData["serves"] as? Int {
            self._recipeServes = recipeServes
        }
        
        if let recipeTime = recipeData["time"] as? String {
            self._recipeTime = recipeTime
        }
        
        if let recipeCategory = recipeData["category"] as? String {
            self._recipeCategory = recipeCategory
        }
        
        if let recipeImageURL = recipeData["imageURL"] as? String {
            self._recipeImageURL = recipeImageURL
        }
        
        if let recipeAuthor = recipeData["createdBy"] as? String {
            self._recipeAuthor = recipeAuthor
        }
        
    }

}
