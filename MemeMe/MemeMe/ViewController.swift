//
//  ViewController.swift
//  MemeMe
//
//  Created by AnnieWilson on 3/18/21.
//

import UIKit
import SPPermissions

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, SPPermissionsDelegate {

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
        TopTextField.placeholder = "Top"
        TopTextField .textAlignment = .center
        BottomTextField.placeholder = "Bottom"
        BottomTextField .textAlignment = .center
    }

    @IBAction func PickAnImage(_ sender: Any) {
        requestPermission()
           
        
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
    
    
    func presentActionAlert() {
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
    actionSheetController.addAction(galleryActionButton)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            actionSheetController.addAction(cameraActionButton)
        }
    
    self.present(actionSheetController, animated: true, completion: nil)
    }
    
    func requestPermission() {

        let cameraState = SPPermission.camera.isAuthorized
        let photoLibraryState = SPPermission.photoLibrary.isAuthorized
        let controller = SPPermissions.list([.camera, .photoLibrary])

        controller.titleText = "Permissions"
        controller.headerText = "Please allow to get started"
        controller.footerText = "These are required to continue"
        
        controller.delegate = self
        
        if !cameraState || !photoLibraryState {
            controller.present(on: self)
        } else {
            presentActionAlert()
        }
        

        

    }
}

