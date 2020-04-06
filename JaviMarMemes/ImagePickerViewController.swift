//
//  ImagePickerViewController.swift
//  JaviMarMemes
//
//  Created by JaviMar on 05/04/2020.
//  Copyright © 2020 JaviMar. All rights reserved.
//

import UIKit

class ImagePickerViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate
{
    // MARK: Variables definitions
    
    @IBOutlet weak var imageViewPickedFromGallery: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextView: UITextField!
    @IBOutlet weak var bottomTextView: UITextField!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var shareButton: UIButton!
    
    // MARK: Override Application LifeCycle functions
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        shareButton.isEnabled = false
        setTextFields(textInput: topTextView, defaultText: "TOP")
        setTextFields(textInput: bottomTextView, defaultText: "BOTTOM")
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        // For devices without camera, need to disable button
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        // Sign up to be notified when the keyboard appears
        subscribeToKeyboardNotifications()
    }

    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    
    // MARK: Text functions
    
    func setTextFields(textInput: UITextField!, defaultText: String)
    {
        let memeTextAttributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.strokeColor : UIColor.black,
             NSAttributedString.Key.foregroundColor : UIColor.white,
             NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
             NSAttributedString.Key.strokeWidth : -3.0 ]
        textInput.text = defaultText
        textInput.defaultTextAttributes = memeTextAttributes
        
        textInput.delegate = self
        textInput.textAlignment = .center
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        // user has tapped into textview. Only erase text if user has not yet entered anything
        if topTextView.text == "TOP" || bottomTextView.text == "BOTTOM"
        {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // User entered return
        textField.endEditing(true)
        return true
    }
    
    
    // MARK: Keyboard management
    
    @objc func keyboardWillShow(_ notification:Notification)
    {
        if bottomTextView.isEditing // only when I am editing the bottom textview
        {
            view.frame.origin.y -= getKeyboardHeight(notification) // substract height
        }
    }

    @objc func keyboardWillHide(_ notification:Notification)
    {
        view.frame.origin.y = 0 // move it back to its original position
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat
    {
       let userInfo = notification.userInfo
       let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
       return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }

    func unsubscribeFromKeyboardNotifications()
    {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    // MARK: Image functions
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        var newImage: UIImage
        if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            newImage = possibleImage
        }
        else if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        {
            newImage = possibleImage
        }
        else
        {
            return
        }
        imageViewPickedFromGallery.image = newImage
        
        // can enable the share button now
        shareButton.isEnabled = true
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        imageViewPickedFromGallery.image = nil
        shareButton.isEnabled = false
        dismiss(animated: true, completion: nil)
    }
    
    func selectImageFromCamera(source: UIImagePickerController.SourceType)
    {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = source
        
        // launch Intent to pick an image
        present(pickerController, animated: true, completion: nil)
    }
       
    @IBAction func showCamera(_ sender: Any)
    {
        selectImageFromCamera(source: UIImagePickerController.SourceType.camera)
    }
    
    @IBAction func pickImageFromGallery(_ sender: Any)
    {
        selectImageFromCamera(source: UIImagePickerController.SourceType.photoLibrary)
    }
    
    
    // MARK: Meme handling
    
    
    
    
    @IBAction func shareMeme(_ sender: Any)
    {
        
        let memeToShare = generateMemedImage()
        
        let activityVC = UIActivityViewController(activityItems: [memeToShare], applicationActivities: nil)
        
        // This checks it has finished with no errors
        activityVC.completionWithItemsHandler = { activity, success, items, error in
            if success
            {
                self.saveMeme(image: memeToShare)
            }
        }
        present(activityVC, animated: true, completion: nil)
    }
    
    
    
    func saveMeme(image: UIImage)
    {
        let meme = Meme(topTextField: topTextView.text!,
                        bottomTextField: bottomTextView.text!,
                        originalImage: imageViewPickedFromGallery.image!,
                        memedImage: image)
        
        
        // TODO: see what to do with the meme struct
        
        
        
    }
    
    	
    func generateMemedImage() -> UIImage
    {
        // First need to hide toolbar and other views otherwise they'll be in the picture
        toolBar.isHidden = true
        shareButton.isHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        // Show back the items
        toolBar.isHidden = false
        shareButton.isHidden = false
            
        return memedImage
    }
}
