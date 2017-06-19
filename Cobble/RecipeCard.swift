//
//  RecipeCard.swift
//  Cobble
//
//  Created by Sabens, Michael G. on 6/17/17.
//  Copyright © 2017 The New Thirty. All rights reserved.
//

import UIKit
import Firebase

class RecipeCard: UITableViewCell {

    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeAuthor: UILabel!
    @IBOutlet weak var recipeCategory: UIImageView!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTime: UILabel!
    @IBOutlet weak var recipeServes: UILabel!
    
    var recipe: Recipe!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //configure cell with data from Recipe model
    
    func configureCell(recipe: Recipe, image: UIImage? = nil) {
        self.recipe = recipe
        self.recipeName.text = recipe.recipeName.capitalized
        self.recipeAuthor.text = recipe.recipeAuthor.capitalized
        self.recipeTime.text = recipe.recipeTime.capitalized
        self.recipeServes.text = "\(recipe.recipeServes ?? 4)"
        self.recipeCategory.image = UIImage(named: recipe.recipeCategory)
        
        //set image from Firebase Storage that we retreived
        
//        if image != nil { // if true, this means we got an image from local cache
//            self.recipeImage.image = image
//            print(UserRecipeFeedVC.imageCache)
//        } else {
//            let ref = Storage.storage().reference(forURL: recipe.recipeImageURL)
//            ref.getData(maxSize: 2 * 1024 * 1024, completion: { (data, error) in
//                if error != nil {
//                    print("Unable to download image from firebase storage")
//                } else {
//                    print("Image downloaded from firebase storage")
//                    //save data to cache
//                    if let imageData = data {
//                        if let image = UIImage(data: imageData) {
//                            self.recipeImage.image = image
//                            let myRecipeImage = recipe.recipeImageURL
//                            UserRecipeFeedVC.imageCache.setObject(image, forKey: myRecipeImage as NSString)
//                        }
//                    }
//                }
//                
//            })
//        }
        
    }

}
