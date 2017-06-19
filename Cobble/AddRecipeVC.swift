//
//  AddRecipeVC.swift
//  Cobble
//
//  Created by Sabens, Michael G. on 6/12/17.
//  Copyright © 2017 The New Thirty. All rights reserved.
//

import UIKit
import Firebase

class AddRecipeVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var recipeName: UITextField!
    @IBOutlet weak var recipeServes: UITextField!
    @IBOutlet weak var recipeTimeToMake: UITextField!
    @IBOutlet weak var recipeIngredients: UITextView!
    @IBOutlet weak var recipeInstructions: UITextView!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    
    let imagePicker = UIImagePickerController()
    
    //uipicker stuff
    let listOfRecipeCategories = ["Beef", "Chicken", "Turkey", "Pasta", "Mexican", "Pizza", "Seafood", "Vegetarian", "Dessert", "Breakfast", "Other" ]
    var recipeCategorySelected = ""
    
    var imageSelected = false
    
    @IBAction func addRecipeImageButtonPressed(_ sender: Any) {
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.modalPresentationStyle = .popover
        present(imagePicker, animated: true, completion: nil)
        imagePicker.popoverPresentationController?.sourceView = sender as? UIView
        
    }
    
    @IBAction func removeRecipeImageButtonPressed(_ sender: Any) {
        
        recipeImage.image = #imageLiteral(resourceName: "recipeImagePlaceholder")
        removeButton.isHidden = true
        addImageButton.isHidden = false
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        categoryPicker.dataSource = self
        categoryPicker.delegate = self
        

    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        //save data to Firebase
        
        guard let recipeName = recipeName.text, recipeName != "" else {
            print("You're missing a recipe name!")
            return
        }
        guard let image = recipeImage.image, imageSelected == true else {
            print("You're missing an image!")
            return
        }
        
        if let imageData = UIImageJPEGRepresentation(image, 0.2) {
            
            //unique identifer for images
            let imageUID = NSUUID().uuidString
            let imageMetadata = StorageMetadata()
            imageMetadata.contentType = "image/jpeg"
            
            FirebaseStorageService.storage.RECIPE_PICTURES_URL.child(imageUID).putData(imageData, metadata: imageMetadata, completion: { (metadata, error) in
                if error != nil {
                    print("Unable to upload image to Firebase Storage")
                } else {
                    print("Uploaded image to Firebase Storage")
                    let downloadURLForUploadedImage = metadata?.downloadURL()?.absoluteString
                }
            })
            
            
        }
        
        
        //dismiss View Controller
        _ = navigationController?.popViewController(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageSelected = true
        recipeImage.image = chosenImage
        addImageButton.isHidden = true
        removeButton.isHidden = false
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //boilerplate for UIPicker
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return listOfRecipeCategories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return listOfRecipeCategories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        recipeCategorySelected = listOfRecipeCategories[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
    

}
