//
//  ViewController.swift
//  MemeMe
//
//  Created by AnnieWilson on 3/18/21.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //MARK: Properties
    let topDelegate = TopTextFieldDelegate()
    let bottomDelegate = BottomTextFieldDelegate()
    
    //MARK: Outlets
   
    @IBOutlet var ImagePickerView: UIImageView!
    @IBOutlet weak var TopTextField: UITextField!
    @IBOutlet weak var BottomTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.TopTextField.delegate = self.topDelegate
        self.BottomTextField.delegate = self.bottomDelegate
//        TopTextField.placeholder = "Top"
//        TopTextField .textAlignment = .center
    }

    @IBAction func PickAnImage(_ sender: Any) {
        
        //Create the AlertController and add Its action like button in Actionsheet
        let actionSheetController: UIAlertController = UIAlertController(title: NSLocalizedString("Upload Image", comment: ""), message: nil, preferredStyle: .actionSheet)
        actionSheetController.view.tintColor = UIColor.black
        
        let cancelActionButton: UIAlertAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { action -> Void in
//              print("Cancel")
        }
        let cameraActionButton: UIAlertAction = UIAlertAction(title: NSLocalizedString("Take Photo", comment: ""), style: .default)
            { action -> Void in self.camera()
            }
        let galleryActionButton: UIAlertAction = UIAlertAction(title: NSLocalizedString("Choose From Gallery", comment: ""), style: .default)
            { action -> Void in self.gallery()
            }
        
        actionSheetController.addAction(cancelActionButton)
        actionSheetController.addAction(cameraActionButton)
        actionSheetController.addAction(galleryActionButton)
        
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    func camera() {
           let myPickerControllerCamera = UIImagePickerController()
           myPickerControllerCamera.delegate = self
           myPickerControllerCamera.sourceType = UIImagePickerController.SourceType.camera
           myPickerControllerCamera.allowsEditing = true
           self.present(myPickerControllerCamera, animated: true, completion: nil)
       }
    
    func gallery() {
        let myPickerControllerGallery = UIImagePickerController()
        myPickerControllerGallery.delegate = self
        myPickerControllerGallery.sourceType = UIImagePickerController.SourceType.photoLibrary
        myPickerControllerGallery.allowsEditing = true
        self.present(myPickerControllerGallery, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage  {
            ImagePickerView.image = image
        }
        picker.dismiss(animated: true)
    }
    
}

