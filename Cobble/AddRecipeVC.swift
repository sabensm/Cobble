//
//  AddRecipeVC.swift
//  Cobble
//
//  Created by Sabens, Michael G. on 6/12/17.
//  Copyright © 2017 The New Thirty. All rights reserved.
//

import UIKit

class AddRecipeVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var recipeName: UITextField!
    @IBOutlet weak var recipeServes: UITextField!
    @IBOutlet weak var recipeTimeToMake: UITextField!
    @IBOutlet weak var recipeIngredients: UITextView!
    @IBOutlet weak var recipeInstructions: UITextView!
    @IBOutlet weak var recipeImage: UIImageView!
    
    @IBAction func addRecipeImageButtonPressed(_ sender: Any) {
        
        //Open image gallery to pick image
        
        //Set recipieImage to selected image.
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        //save data to Firebase
        
            //TODO
        
        //dismiss View Controller
        
        _ = navigationController?.popViewController(animated: true)
    }
    

}
