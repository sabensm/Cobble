//
//  RecipeCard.swift
//  Cobble
//
//  Created by Sabens, Michael G. on 6/17/17.
//  Copyright © 2017 The New Thirty. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

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
        self.recipeServes.text = recipe.recipeServes
        self.recipeCategory.image = UIImage(named: recipe.recipeCategory)
        
        //configure image using Kingfisher
        let resource = ImageResource(downloadURL: URL(string: recipe.recipeImageURL)!)
        recipeImage.kf.indicatorType = .activity
        recipeImage.kf.setImage(with: resource, options: [.transition(.fade(0.2))])
        
    }

}
