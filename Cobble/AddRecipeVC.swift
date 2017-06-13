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
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var removeButton: UIButton!
    
    let imagePicker = UIImagePickerController()
    
    @IBAction func addRecipeImageButtonPressed(_ sender: Any) {
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
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

    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        //save data to Firebase
        
            //TODO
        
        //dismiss View Controller
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        recipeImage.image = chosenImage
        addImageButton.isHidden = true
        removeButton.isHidden = false
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    

}
