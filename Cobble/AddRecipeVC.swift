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
    let listOfRecipeCategories = ["Category", "Beef", "Chicken", "Turkey", "Pasta", "Mexican", "Pizza", "Seafood", "Vegetarian", "Dessert", "Breakfast", "Other" ]
    var recipeCategorySelected = "other"
    
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
        imageSelected = false
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
                    if let url = downloadURLForUploadedImage {
                        self.newPostToFirebaseDatabase(imageURL: url)
                    }
                    
                }
            })
            
            
        }
        
        //dismiss View Controller -- ultamitely we'll only want to do this upon complettion of Image Upload and Successful post - for now, we'll introduce an artfical delay which will be a little over 1 second - more than enough time for the image to upload on a fast conneciton
        let when = DispatchTime.now() + 1.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            _ = self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    func newPostToFirebaseDatabase(imageURL: String) {
        
        let post: Dictionary<String, String> = [
            "category": recipeCategorySelected.lowercased(),
            "createdBy": (UserServices.users.currentUser?.email!)!,
            "imageURL": imageURL,
            "ingredients": recipeIngredients.text!,
            "instructions": recipeInstructions.text!,
            "serves": recipeServes.text!,
            "time": recipeTimeToMake.text!,
            "name": recipeName.text!,
            "userID": (UserServices.users.currentUser?.uid)!
        ]
        
        let postUID = NSUUID().uuidString
        let firebasePost = FirebaseDataService.database.RECIPES_URL.child(postUID)
        firebasePost.setValue(post)
        FirebaseDataService.database.USERS_URL.child((UserServices.users.currentUser?.uid)!).child("posts").updateChildValues([postUID: true])
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    

}
