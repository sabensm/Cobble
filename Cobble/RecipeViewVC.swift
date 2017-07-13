//
//  RecipeViewVC.swift
//  Cobble
//
//  Created by Sabens, Michael G. on 6/26/17.
//  Copyright © 2017 The New Thirty. All rights reserved.
//

import UIKit
import Kingfisher

class RecipeViewVC: UIViewController {

    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeAuthorNameLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeIngredientsLabel: UILabel!
    @IBOutlet weak var recipeInstructionsLabel: UILabel!
    
    var recipeName: String = ""
    var recipeAuthorName: String = ""
    var recipeImageURL: String = ""
    var recipeIngredients: String = ""
    var recipeInstructions: String = ""
    
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint! // we will use this to set the height of the content in our scrollview. 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeTitleLabel.text = recipeName
        recipeAuthorNameLabel.text = recipeAuthorName
        recipeIngredientsLabel.text = recipeIngredients
        recipeInstructionsLabel.text = recipeInstructions
        
        //configure image using King Fisher
        
        let resource = ImageResource(downloadURL: URL(string: recipeImageURL)!)
        recipeImage.kf.indicatorType = .activity
        recipeImage.kf.setImage(with: resource, options: [.transition(.fade(0.2))])
        
        
        self.scrollViewHeight.constant = UIScreen.main.bounds.size.height

        // Do any additional setup after loading the view.
    }

}
